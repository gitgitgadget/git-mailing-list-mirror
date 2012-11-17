From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] completion: fix args of run_completion() test helper
Date: Sat, 17 Nov 2012 15:02:49 -0800
Message-ID: <20121117230249.GB3815@elie.Belkin>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:03:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZrPo-0002FS-78
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 00:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab2KQXCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 18:02:54 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:48606 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab2KQXCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 18:02:53 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so199703dak.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 15:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3K6DGThjcGWymApCpcuNpAyC47MMIXQZPatv5Z0j/6I=;
        b=BYM2I+9PTe52M0r97+bKownLbZudNUphTm32qwfRkvCpxQoA1Kg2c4jyIZ5yojypNn
         eEXOMFnBZfnkB/cas54xh3PIue6xt7D/wT1mglpD1kgOtE6fskDrkf/XBE8GzRSr0BPi
         Rs/XKtpcZmAI0Yz8K0hIsXS6/KmSrT1xBk3Cez/iS8raoOPR3qyC4oW3JMse02cruaNo
         HBi4V3++nprrx6JUIM0vgvj7V/neHnvd588lnxcJD7GWHal4HcaaWvIPVoy9wyjuL7Mx
         sFA7DOzFYmhyf/jArgH1WeqkoLtKefYeuH0vYw4fjALoJaeYLJ/u72m3fNxJQuKXm+ed
         SuUA==
Received: by 10.68.138.137 with SMTP id qq9mr27953028pbb.74.1353193373490;
        Sat, 17 Nov 2012 15:02:53 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qj6sm3518942pbb.69.2012.11.17.15.02.52
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 15:02:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353150353-29874-3-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209984>

SZEDER G=C3=A1bor wrote:

> Fix this by passing the command line to run_completion() as separate
> words.

Good catch.  The change makes sense, the code looks saner after the
fix, and since this is test code any breakage should be caught
quickly, so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
