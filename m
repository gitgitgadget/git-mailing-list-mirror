From: Michael Haggerty <haggerty@jpk.com>
Subject: t4014 broken by 43ae9f47ab: format-patch: use default email for generating
 message ids
Date: Thu, 24 May 2012 14:01:57 +0200
Message-ID: <4FBE2335.2090903@jpk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 14:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXWsI-0005ze-S0
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 14:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab2EXMKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 08:10:25 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:54978 "EHLO
	mx.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751456Ab2EXMKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 08:10:22 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 08:10:22 EDT
Received: from imap.berlin.jpk.com (unknown [10.0.0.25])
	by mx.berlin.jpk.com (Postfix) with ESMTPS id 11C8F2480A3;
	Thu, 24 May 2012 14:01:58 +0200 (CEST)
Received: from [192.168.101.152] (michael.berlin.jpk.com [192.168.101.152])
	(Authenticated sender: mhagger)
	by imap.berlin.jpk.com (Postfix) with ESMTPSA id 851CC613CC;
	Thu, 24 May 2012 14:02:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198366>

On my setup, the above commit causes 12 tests in t4014 to fail.  For=20
example, test 25:

> expecting success:
>         check_threading expect.thread --thread master
>
> --- expect.thread       2012-05-24 11:57:26.841337237 +0000
> +++ actual      2012-05-24 11:57:26.853337255 +0000
> @@ -1,10 +1,10 @@
>  ---
> -Message-Id: <0>
> +Message-Id: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git=
=2Emhagger@michael.(none)>
>  ---
> -Message-Id: <1>
> -In-Reply-To: <0>
> -References: <0>
> +Message-Id: <fd00575a8382ce27c62b83730a40bcff1dc2f25f.1337860646.git=
=2Emhagger@michael.(none)>
> +In-Reply-To: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.gi=
t.mhagger@michael.(none)>
> +References: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git=
=2Emhagger@michael.(none)>
>  ---
> -Message-Id: <2>
> -In-Reply-To: <0>
> -References: <0>
> +Message-Id: <18ed22aae56367787c36a882bd61281e07994f11.1337860646.git=
=2Emhagger@michael.(none)>
> +In-Reply-To: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.gi=
t.mhagger@michael.(none)>
> +References: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git=
=2Emhagger@michael.(none)>
> not ok - 25 thread

Beyond bisecting, I haven't looked into this problem further.  Let me=20
know if you need more info.

Michael

--=20
Michael Haggerty
Head of Software Development

JPK Instruments AG
Bouch=E9str. 12
12435 Berlin, Germany

tel:  +49 30 5331 12070
fax:  +49 30 5331 22555
mail: haggerty@jpk.com
web:  www.jpk.com, www.nanobioviews.net

Aufsichtsrat: Dr. Franz-Ferdinand von Falkenhausen (Vorsitzender)
Vorstand:     Torsten J=E4hnke, Frank Pelzer, J=F6rn Kamps, Ren=E9 Gr=FC=
nberg

JPKinstruments Aktiengesellschaft
Amtsgericht Berlin-Charlottenburg
HRB 75513
