From: Lea Wiemann <lewiemann@gmail.com>
Subject: Adding a 'version' command to the server (was: git@vger.kernel.org)
Date: Sat, 28 Jun 2008 01:07:40 +0200
Message-ID: <486572BC.9070201@gmail.com>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCN3o-0008T6-Dq
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766011AbYF0XHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766009AbYF0XHo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:07:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:61141 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766001AbYF0XHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:07:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so338318fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=t6qUSrWfbU5hAST1lj7rpsBdDR9w51BKV888fP2TmGQ=;
        b=RtmBcoUG80zibvb9k0qOBRz0DzMN768muIOKmdh9tILW1u1o+6QTZUXth+kvBXlYWo
         +oG2+JXVfShTIJ83tvCBytYFKiEyiTjxSQrpbXShUiRfGnOw87DD9M8NJkpOw98mwJ8v
         tCwTOJMBK8VqSSB46twu0WKkY/THfPl4MItfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=LP4QqpMGiIsoEqce5Jicy/cG/4EltUVUMeNVNMyxcagaJMJtrunLiEqxv6x4ew+Pw6
         pHkL4+dmmTAawhC6tRKO2dIqxDOBIYO39OHMKQjE58CzbWgxrsATkbxEJ0c+o2Lf4yKQ
         +00ogPuWIQuJ3Y7BDgtOCLtWF6EBNn/a/1rJk=
Received: by 10.86.87.5 with SMTP id k5mr2555524fgb.59.1214608061771;
        Fri, 27 Jun 2008 16:07:41 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.234.14])
        by mx.google.com with ESMTPS id e20sm3857156fga.1.2008.06.27.16.07.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 16:07:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7viqvupm3l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86673>

Junio C Hamano wrote:
> It is still possible to connect to older remote end with new clients, but
> you have to explicitly ask for "git-upload-pack" by using --upload-pack=
> option when running "git fetch"

Now that the current git won't work with older servers anyway, what 
about using this opportunity to add a 'version' command to the server? 
With such a command, such problems would seem to be quite easily 
avoidable in the future, since the client can discriminate based on the 
server's version.

I'm not sure how to implement this (the problems seem to be that (a) it 
needs to work with git-shell and real shells, and (b) that older clients 
must not be supplied with a version number in order not to break them), 
but perhaps this is worth pondering.

Apologies if this has been discussed before.

-- Lea
