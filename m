From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: gitk won't show notes?
Date: Tue, 07 Apr 2015 13:08:26 -0400
Message-ID: <55240F0A.80902@ubuntu.com>
References: <551D99B9.7040200@ubuntu.com> <5523DE66.8060904@drmicha.warpmail.net> <5523E479.2010701@ubuntu.com> <5523E5FF.8060101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfX0f-0002NL-74
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 19:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbDGRJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 13:09:52 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36008 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbbDGRJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 13:09:51 -0400
Received: by qku63 with SMTP id 63so55700983qku.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=akc9ImqxIrRLUmhSrgwhxsZp+GRDTNiQyOC5OwTfM+k=;
        b=ufYq6//vSMPwrSpBQ1esUgme2Z5BEfDaC/FDiQ+ZgbxxvCxdWlTvwWpjcIIq5kh34T
         ThSbT4hYHF8EkXUCYKSocT/WIdmRGnMMP/J3FnNbF26UmjiJOBzHIpUoTkq4XLedio5h
         8hatlqUbp7yQ+ZmGN3/SJnv68RDVLzSTP7SvLEIugacWjj+emUK352GzKDP64zCShE2u
         g357CSM29PfZ2gLO0j9tT/wOh0bNNrHO3Kh3SjE3MHwkxYfdhr8+K60o+pqkvXTMCAu3
         rvQEjUTipZFnDQxMGtWbLMJJ/iNQm789EM3/B1V/SqsOYY9pMKE4lOWYCdIO1oCVhCo4
         v3Rw==
X-Received: by 10.55.33.142 with SMTP id f14mr40792246qki.1.1428426591222;
        Tue, 07 Apr 2015 10:09:51 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id q193sm5741541qha.14.2015.04.07.10.09.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 10:09:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5523E5FF.8060101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266927>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/7/2015 10:13 AM, Michael J Gruber wrote:
> Seriously: gitk knows F5 and Shift-F5 for refresh, and I think the 
> latter is the thorougher refreshment.

Neither one makes newly added notes show up.  The only way seems to be
to close and restart gitk.  Looks like a bug.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVJA8KAAoJENRVrw2cjl5RrIgH/2FTWanl7IUyusBMmwR5buLP
R0yVGf0xF6xzG3SmayDh9EzmhoSJDBFjbqlb8mG1pbgMQfRNKaCjnlk97WRQ5qDr
X9CHImC4HODZVT/jAgCX5HsCEN62nIZBUfliQOH3PFbbAp6LG/Y/milZk3Ek+srL
guFFzFsCyv88uAjDJMMM4Ub9Sg3rtKckZ2JeprNv8VDFuqvZWxRPA3G+7TYSTBdE
wj73xIjyg0KVP1yAR/833TF7srDaRUnB3Z/AfDXAhekYum5TZnEZNQUh1DpiAnus
dC6T8LWu14PebzmiZy+7QV3cakhlt9ZjrHW9eRBVzY7RAm8JRY1GSgbCQJ0pIQo=
=EWg/
-----END PGP SIGNATURE-----
