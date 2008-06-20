From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 15:13:50 +0200
Message-ID: <200806201513.51034.jnareb@gmail.com>
References: <20080620082034.GA24913@elte.hu> <m3d4mcmq20.fsf@localhost.localdomain> <237967ef0806200602v6b95939fm2663be849799e2de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gS8-0007Th-Hz
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYFTNN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbYFTNN7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:13:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:6862 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYFTNN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:13:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so919633waf.23
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=J4MCpPGDes711h4IE8b+6SUJFUscLuctcICUBuIawGE=;
        b=noNB0X6iAacafST/uYVAeYZhT+r7DpeolOTeUMzpEUSEg0fyk5CrZbWgkVaNlWI+dH
         TY+H+q+F86WOWoI4f8WGoGASpc2Ztpky7IC5g6saZ42sGqu8A/3otnyIcgajHoxv46mA
         5lBKwgPbhDBvVMbApEdSOfZ2IIDIwlayLZGME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qXlsgPTOW+ijBhVOCDopmY+llfKNEF2sZwCpy68w9nWmNRpwCAipYat9nPD/2vMced
         zd/OLdYIS3ERinwhshb+gX1V8SnCPPFfoBCrOeIJyJpBtqRwB+NIT62LFmV6bXSTj5fT
         4WnEyYAg29xIJ8hIYztrU2xsBKhDc9LLuGfbw=
Received: by 10.114.151.13 with SMTP id y13mr4276253wad.134.1213967635893;
        Fri, 20 Jun 2008 06:13:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.51])
        by mx.google.com with ESMTPS id 10sm3217120wrl.11.2008.06.20.06.13.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 06:13:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <237967ef0806200602v6b95939fm2663be849799e2de@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85641>

Mikael Magnusson wrote:
> 2008/6/20 Jakub Narebski <jnareb@gmail.com>:
> 
>> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
>> documented anywhere, though), so you could have used
>>
>>        git diff 7def2be1^!
>>
>>>    [ time passes as i read the manpage - the final thing i do when
>>>      every other measure fails ;-) ]
> 
> With some grepping, i found this in git-rev-parse,
> 
>        Two other shorthands for naming a set that is formed by a commit and its parent
>        commits exists. r1^@ notation means all parents of r1. r1^! includes commit r1
>        but excludes its all parents.

A bit strange is that neither "git rev-parse pu^!" nor "git rev-parse pu^@"
work, while the same works with git-rev-list.  WTF?

-- 
Jakub Narebski
Poland
