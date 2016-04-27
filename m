From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Wed, 27 Apr 2016 17:18:34 +0700
Message-ID: <20160427101833.GA5536@lanh>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
 <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:18:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avMY6-0005a3-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 12:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbcD0KSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 06:18:17 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36098 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcD0KSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 06:18:16 -0400
Received: by mail-pf0-f180.google.com with SMTP id c189so18559923pfb.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjcVtgCSbzabr/R44k/D0BMNDjbkCYI1cEEbUtJ3Auw=;
        b=OHKsPOBBZuRjsc6ngHY26JOvCxr4qVNcxUh+XzQfBLtu1g8b5IpxFbOIexOOR5K58Y
         Wey5V4wjUeBk6yElC+Xc/M8i2hzb5TMDAX/t/eKW5VLkCcPphJ0t2NCyOEyd+v57YX5K
         pr6W1bTDyLZhdYeMLWiA+mqF4zhpesIWby+c4mfQtlZrXyxUwk4mQ8Gs/7PZojPgVOD6
         W1PmysT+UcmpRRwkT97R1uloSeenfylJiJ7p4RtrxTgE/gz9k+kWaoBep4cI1i/Cbv4J
         6k7xFVtAiGf/UAozyabcauE3trGmRGRM9/cegV0capVpx3UWAGbcxL+rahnB9HMhLy50
         7thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjcVtgCSbzabr/R44k/D0BMNDjbkCYI1cEEbUtJ3Auw=;
        b=J9viRfqnqi151SC/3bztRhBkePpnTaNCBBe7A08R/HfKa3KbvjVGoO0h19y9dwoyT8
         o9TwjSDhI2Z9oyZTDzKYBhrG1ZxcSVP4+OYJGQYqzsa6JyxIEsOrGtBv2dR60WBuCicc
         eKcwI7/KeusM3ySTJYGRBwYZGt7cLSfsPBwuxFigds981OIgA0cC2FrIqQb9B1dzLa5x
         jg+IcFHQyxi6AyoKkPNcaUEvFf6CNo8zaunDfgcwWgeMIMG2mONJEbLeFlf15V28770p
         0SaIwlhziw6zQZz4FXNP8OPN6A4KGpd2X0wa2zILFI3/ceo5wwXh8Q9m8oquueQjQ2Kj
         rTRw==
X-Gm-Message-State: AOPr4FVtn4hrleYrh8A/l71E/wX27lCAaP2tc7QdEdlPKj6Kp90y1qh10S/GJCNvlonYOQ==
X-Received: by 10.98.98.131 with SMTP id w125mr10463676pfb.112.1461752294963;
        Wed, 27 Apr 2016 03:18:14 -0700 (PDT)
Received: from lanh ([171.232.191.76])
        by smtp.gmail.com with ESMTPSA id t85sm5160655pfi.55.2016.04.27.03.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 03:18:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 27 Apr 2016 17:18:34 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292717>

On Wed, Apr 27, 2016 at 07:52:41AM +0700, Duy Nguyen wrote:
> > Can you (or somebody else) double check that the resulting Makefile
> > gets the build dependencies and exec path right?
> >
> > I am seeing occasional failure from t0040 when checking out between
> > master and pu, and between the branches test-parse-options do change
> > behaviour which explains the breakage.
> 
> There is a problem moving between master and next/pu though.
> bin-wrappers is not regenerated after the move so it could point to
> the old binaries (in the other place). Not sure how to fix that
> cleanly, will think of something, maybe, in about 8 hours.

This patch forces bin-wrappers regeneration every time a test program
is updated. A bit wasteful, but I don't see a better option (which is
also why I limit this to test programs only).

A similar patch (without "t/helper/") could be applied on
maint/master, otherwise bin-wrappers is still not updated when moving
back from next/pu. And of course the problem will pop up again if you
build old history...

-- 8< --
diff --git a/Makefile b/Makefile
index dd178ee..6b6a844 100644
--- a/Makefile
+++ b/Makefile
@@ -2196,10 +2196,13 @@ GIT-PYTHON-VARS: FORCE
 endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+bindir_test_programs := $(patsubst %,bin-wrappers/%,$(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 all:: $(NO_INSTALL)
 
+$(bindir_test_programs): bin-wrappers/%: t/helper/%$X
+
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-- 8< --

-- 
Duy
