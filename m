From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Issues with file status over samba
Date: Wed, 17 Jun 2009 22:45:25 +0200
Message-ID: <46a038f90906171345n5a248d1bl253bc49baa819cd8@mail.gmail.com>
References: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com>
	 <3dfcd29f-a1cd-4007-b962-2cf5156ab708@g19g2000yql.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jiho <jo.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH210-0002dJ-Cn
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbZFQUpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZFQUpb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:45:31 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52209 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760175AbZFQUpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:45:24 -0400
Received: by bwz9 with SMTP id 9so646836bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z0FyObq5yMhwsqBRvMzQ+jHPlpgJu65OBHZpLNuhkcw=;
        b=XtwiGm0bP6tzMUR/bP3YtQ1MjwgE+yYPFa9W8tqF5dM0dapVcLUJcZEKqxgFHvWS15
         DnF+uCWVFZ4Tz/ToQ3myVDDjbvv+QeCX/nwJE/rkXsYqSvHp+p65UePu8xnKkWaRN17z
         jxtalrFHzw9hlr+EKlPJheYpnPe5zvNMGQPZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B/OSkMBpHg5NUA17Wvm0xlwtB+EKKKLmKIzZH7zo2oSUMgS2+4qmb4MplQYd58dmOo
         mTPt76rmyvPY9hwKLR/J03vadthzFLE4U6EM4UD2TuYjH1Rzk216AwKxq83aeEu9oMVN
         zpLxx7jgKLblx/L4HmN065U+Rcx1x6ehba5t0=
Received: by 10.204.50.195 with SMTP id a3mr507017bkg.94.1245271525654; Wed, 
	17 Jun 2009 13:45:25 -0700 (PDT)
In-Reply-To: <3dfcd29f-a1cd-4007-b962-2cf5156ab708@g19g2000yql.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121772>

On Wed, Jun 17, 2009 at 8:51 PM, jiho<jo.lists@gmail.com> wrote:
> This is not an issue of clock differences betweent eh two computer
> because setting the time on the server to -1h does not help.

How about having ntp running on both?

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
