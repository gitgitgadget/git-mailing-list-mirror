From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 status
Date: Sat, 20 Oct 2012 09:58:17 +0200
Message-ID: <50825999.5080208@op5.se>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se> <7vharpv77n.fsf@alter.siamese.dyndns.org> <nnglih0jotj.fsf@transit.us.cray.com> <7vfw78s1kd.fsf@alter.siamese.dyndns.org> <nngsjb8i30w.fsf@transit.us.cray.com> <7v6284qfw8.fsf@alter.siamese.dyndns.org> <20120827214027.GA511@vidovic> <nngr4qqhp7x.fsf@transit.us.cray.com> <7vvcg2zwvq.fsf@alter.siamese.dyndns.org> <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com> <CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com> <7vvce6i5j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	dag@cray.com, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	greened@obbligato.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:58:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPTx6-0002qk-QX
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 09:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab2JTH6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 03:58:24 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58466 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2JTH6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 03:58:23 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so784245lbo.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rXFWNUT/eIehvlTXqyi5SkhzzMSU4F2s5zBaOA68hF4=;
        b=AdtYrEGbt2NGIH7BMRwWI3PL79kEoPlwbenNDBojDXP9L0UDBZ9P3cUmF5boAus9uN
         yTZkpuasod6naIp3mjRAx60R0gAyfcgmyrikEYm+b6W+i/6i2B/tZNWJEwsvgf+OlH4j
         RLO6s8idKRFjZiaL5Imy3CMPtcpIMNuuRXmO1R5Zqt2s4isZ3DmhbC8yt23GdjuwetWJ
         VFgysMgTpOeNXHmJHZcGMZODVSonhlVs1RRdQE/WeaKlLJ0ih5HyqRMI2I/ebU910gZZ
         prO8jke8n7BVP+/hvi4XXReCIRQpwrxmGwIPiiNgKlpZVPIQYvZG9Xqjc+iYkETTG6o7
         aUyw==
Received: by 10.112.39.161 with SMTP id q1mr1404231lbk.131.1350719901395;
        Sat, 20 Oct 2012 00:58:21 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id e4sm1211444lby.12.2012.10.20.00.58.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 00:58:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120911 Thunderbird/15.0.1
In-Reply-To: <7vvce6i5j2.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlEM/Szg5CdMP6J1XcuJMWv0CxM0mMXGZU7V3fST4W4Is4RAczcbmMIcUHHpCsMJqxqpC59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208081>

On 10/19/2012 10:13 PM, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> Thiago Farina wrote:
>>> [...]
>>> With some structure like:
>>>
>>> include/git.h
>>> src/git.c
>>>
>>> ...
>>>
>>> whatever.
>>> [...]
>>
>> Junio- is it reasonable to expect the directory-restructuring by 2.0?
> 
> I actually hate "include/git.h vs src/git.c"; you have distinction
> between .c and .h already.
> 

Agreed. The way libgit2 does it is to have "src/tag.[ch]", which are
for internal use, and then "src/include/tag.h" which is the published
version that others can use to write code against the tag library.
src/tag.h always includes src/include/tag.h, so no code needs to be
duplicated, but internal parts of the library can still use lower-
level stuff if it wants to. It's a good compromise when creating a
library from application code and there were no opaque types from
the start.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
