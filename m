From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 1/5] Scripts to install, delete and clear a MediaWiki
Date: Thu, 14 Jun 2012 10:58:23 +0200
Message-ID: <vpqlijqb780.fsf@bauges.imag.fr>
References: <4FD8C71F.1070508@ensimag.imag.fr>
	<1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5t2-0002Mw-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 10:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab2FNI6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 04:58:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59600 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189Ab2FNI6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:58:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5E8wOq9030942
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:58:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sf5sm-0007Sc-4O; Thu, 14 Jun 2012 10:58:24 +0200
In-Reply-To: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	(Simon Cathebras's message of "Wed, 13 Jun 2012 19:03:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 10:58:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E8wOq9030942
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340269107.36916@9QY9+vb2x3Fy4e9gnbM3MA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199984>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> +function get ($page_name = "") {
> +        $curl = curl_init();
> +        $page_name_add = "";
> +        if ($page_name != "") {
> +                $page_name_add = '?page='.$page_name;
> +        }
> +	$url = $GLOBALS['url'].$page_name_add;
> +        $tmp_cookie=$GLOBALS['tmp_cookie'];
> +        curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
> +        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
> +        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
> +        curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
> +        curl_setopt($curl, CURLOPT_HEADER, true);
> +        curl_setopt($curl, CURLOPT_URL,$url);
> +
> +        $page = curl_exec($curl);
> +        curl_close($curl);
> +        return $page;
> +}

Mixed tab/space indentation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
