From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] glossary: update description of "tag"
Date: Thu, 23 Jun 2011 18:19:46 -0400
Message-ID: <4E03BC02.5080705@sunshineco.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org> <1308847958-3429-1-git-send-email-gitster@pobox.com> <1308847958-3429-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 00:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZsFg-0004x5-3h
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 00:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933833Ab1FWWTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 18:19:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46961 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548Ab1FWWTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 18:19:49 -0400
Received: by qyk9 with SMTP id 9so1317637qyk.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wV6XxpO2dvFUPAItiNgoIKW57yYeD28E81Mbr3RKNaI=;
        b=IgEN/sT9BzUU7qecu0hSS6Uyv/UnStduRfY0B7OgJdBXHbD5Ree2cYhkz1TqP2PXtf
         fHQvke+Ip2JlLloXcKlXzQNWrbXdtfwM4WeI5i+KXQe3T+G+KcOMOUj9vcfRjaXCYTrI
         ySJLddn55EKhueaiuhLGQj5EZULgd73GrQjbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eeQoYAgo8Y05alovQ5a2KRd6OHxmoZ3lDq5VtFjg394i6FItz3KmTQ1V5yNPriI3M0
         QibxnIYScrMX5xx8lRyURas2TgG2U5UybouQFC2gy3EGgC/NHmaeZyzzB4naNVtBwVzM
         po1IdcH3kP8dqrbd4QE9veBnvrn+h7VRVs4yg=
Received: by 10.224.210.8 with SMTP id gi8mr2130857qab.292.1308867588548;
        Thu, 23 Jun 2011 15:19:48 -0700 (PDT)
Received: from [192.168.1.2] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id d2sm1518577qcs.21.2011.06.23.15.19.47
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 15:19:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1308847958-3429-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176298>

On 6/23/2011 12:52 PM, Junio C Hamano wrote:
> +	In contrast to a<<def_head,head>>, a tag is not updated by
> +	 the `commit` command. A git tag has nothing to do with	a Lisp

Line begins with tab+space but you probably want only tab. "with" and 
"a" are separated by a tab but likely ought to be separated by a space.

s/^\t /\t/
s/with\ta/with a/

-- ES
