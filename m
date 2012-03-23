From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Fri, 23 Mar 2012 11:07:21 +0100
Message-ID: <4F6C4B59.8060102@op5.se>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com> <7v1uokxxzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Hitoshi Mitake <h.mitake@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1PZ-0007f6-1D
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab2CWKHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 06:07:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46414 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab2CWKHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:07:22 -0400
Received: by lbbgm6 with SMTP id gm6so2416509lbb.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 03:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=cqKMjC95gVf+F9F0NstiBEh1kblIyQ2HBj78hd4xPqk=;
        b=bcOzerQTGDCxgqWg0GFjxwopkOlMf2Sve3uWAwR8ArE70HySRsD+DLozOVSxIU5RbO
         8OIQbyJIFZNcpksgOZLM3uCyYpDJDEP2WN9XzE5IFfxhzEO9Bfi2zFMFH1JbPIUj11MP
         hkN82cYksCzkdIOkbKas9ZjxRvERuXpqPITDa8MppvTaYCHqNtl19emcsNXf9G3CNOLN
         QaqtkgAFu0FiUvqjqJy0pi9q/2lbIVgS0v6jJB0Dh+wKpK+gdI/cQ4CBI7Sc0pha9IxL
         8wlYDV9Wrh4BRkgofkurkyoy2pfnG9BdyT3fsjJvgAsbR9ov0763I4se0kbbaymqpHJi
         k/ZA==
Received: by 10.112.47.161 with SMTP id e1mr4788600lbn.42.1332497240747;
        Fri, 23 Mar 2012 03:07:20 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id p9sm9594285lbw.10.2012.03.23.03.07.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 03:07:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7v1uokxxzh.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnrKuUfLzHVyemOCrssOOhq/WweFDQvGyWwFgc9Np4TnQG96nw6p70oVBCSDWGNbHR1OLJ6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193748>

On 03/22/2012 08:00 PM, Junio C Hamano wrote:
> Hitoshi Mitake<h.mitake@gmail.com>  writes:
> 
>> If the pager can recognize the end of each commit, more confortable viewing of
>> git-log's output will be possible.
> 
> I think people just use "/^commit .*<RET>" once and then nagivate with "n"
> (and to change direction, "?<RET>") for this.
> 

Or capital N.

It's mostly useful when one wants to view the patch as well as the message,
so an alias like

    logp = !PAGER='less -p ^commit' git log -p

should work well, and also make LISP nerds giggle.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
