From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
Date: Sat, 13 Apr 2013 00:20:48 +0200
Message-ID: <516888C0.90501@gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com> <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412064953.GB5710@elie.Belkin> <7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:20:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQmL4-0004j3-20
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab3DLWUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 18:20:54 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:57814 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3DLWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 18:20:53 -0400
Received: by mail-ea0-f171.google.com with SMTP id b15so1417325eae.30
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=62AAUhfLh6beuinTvbQcfoMpVkqu0o7IAs162fzzD5o=;
        b=EpZoPvyJBcNrZJHFAerbPvIEVn9itvS4T6BDepvjiM9maVOleSgQf46o6s9Pyek9rK
         BeSzS5tk+DHymnHjFBWRtbsFNhkmp2qPVev2dqlmAVcxLzIuno7XSDrJ0w1aokXZtU/l
         BmoCgSbvT9u+haI09Ymn4z/87hpVW7v2vJ5w0Ts86IkOXm4OZdIp1I/Fge6AGCMu69Fi
         CWlA6/mNLupGGjB5GJxuWnRkwxufJAO712jSFlOLrvrrILiPpRgOpVXAsytqMkps7DZK
         OAfnp3oqSWtUUAzeTtJU1DFiNAMvVr/mC9Hn7YI89KctYDlJo3MvhnhqL1FY2jQpn9R1
         sknQ==
X-Received: by 10.15.31.197 with SMTP id y45mr32410751eeu.18.1365805251985;
        Fri, 12 Apr 2013 15:20:51 -0700 (PDT)
Received: from [192.168.1.14] (aeed59.neoplus.adsl.tpnet.pl. [79.186.107.59])
        by mx.google.com with ESMTPS id f47sm13368264eep.13.2013.04.12.15.20.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 15:20:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221032>

On Fri, 12 April 2013, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>    Note that if per-instance configuration file exists, then system-wide
>> -  configuration is _not used at all_.  This is quite untypical and suprising
>> +  configuration is _not used at all_.  This is quite untypical and surprising
>>    behavior.  On the other hand changing current behavior would break backwards
>>    compatibility and can lead to unexpected changes in gitweb behavior.
>>    Therefore gitweb also looks for common system-wide configuration file,
>
> Hmm, "atypical", isn't it?
>
> The flow of the text is awkward.  "This is bad. Oh the other hand,
> better is broken. Therefore ..." forces readers to make multiple
> guesses while reading: "ok, bad, so you plan to change it and warn
> us about upcoming change?  oh, not that, changing it is bad, so we
> have to live with it?  oh, not that, there is another one that is
> common and that is what we can use".
>
> It may be a good idea to rewrite this paragraph to avoid such a
> mental roller-coaster in the first place.
>
>     The GITWEB_CONFIG_SYSTEM system-wide configuration file is only
>     used for instances that lack per-instance configuration file.
>     You can use GITWEB_CONFIG_COMMON file to keep common default
>     settings that apply to all instances.
>
> or something.
>
> Not asking for a re-roll, but it may be a potential follow-up candidate.

Perhaps something like this?

Note that this change avoids repetition of build / environmental
configuration variable (I think the paragraph above, not touched
in this patch, also might need rewrite).

-- >8 --
Subject: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM

The flow of the text describing GITWEB_CONFIG_SYSTEM and
GITWEB_CONFIG_COMMON in gitweb/INSTALL is awkward.  "This is
bad. Oh the other hand, better is broken. Therefore ..." forces
readers to make multiple guesses while reading: "ok, bad, so you plan
to change it and warn us about upcoming change?  oh, not that,
changing it is bad, so we have to live with it?  oh, not that, there
is another one that is common and that is what we can use".

Better rewrite said paragraph to avoid such a mental roller-coaster in
the first place.

Signed-off-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/INSTALL |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d45406..7ad1050 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -243,14 +243,12 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   GITWEB_CONFIG_SYSTEM build configuration variable, and override it
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
-  Note that if per-instance configuration file exists, then system-wide
-  configuration is _not used at all_.  This is quite untypical and suprising
-  behavior.  On the other hand changing current behavior would break backwards
-  compatibility and can lead to unexpected changes in gitweb behavior.
-  Therefore gitweb also looks for common system-wide configuration file,
-  normally /etc/gitweb-common.conf (set during build time using build time
-  configuration variable GITWEB_CONFIG_COMMON, set it at runtime using
-  environment variable with the same name).  Settings from per-instance or
+
+  Note that the GITWEB_CONFIG_SYSTEM system-wide configuration file is
+  only used for instances that lack per-instance configuration file.
+  You can use GITWEB_CONFIG_COMMON common system-wide configuration
+  file (normally /etc/gitweb-common.conf) to keep common default
+  settings that apply to all instances.  Settings from per-instance or
   system-wide configuration file override those from common system-wide
   configuration file.
 
-- 
1.7.10.4
