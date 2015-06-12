From: Anish R Athalye <aathalye@mit.edu>
Subject: git_config_set(?) adding and removing creates extraneous lines
Date: Fri, 12 Jun 2015 04:59:06 +0000
Message-ID: <26A24781-3981-44B6-8174-09532D93774C@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 07:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3H8q-0005g9-6P
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 07:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbbFLFE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 01:04:27 -0400
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15]:58606 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037AbbFLFEY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 01:04:24 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2015 01:04:24 EDT
X-AuditID: 1209190f-f79936d000000d16-ca-557a671c36ae
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F9.A9.03350.C176A755; Fri, 12 Jun 2015 00:59:08 -0400 (EDT)
Received: from outgoing-exchange-3.mit.edu (outgoing-exchange-3.mit.edu [18.9.28.13])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id t5C4x8H6008643
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 00:59:08 -0400
Received: from OC11EXEDGE3.EXCHANGE.MIT.EDU (oc11exedge3.exchange.mit.edu [18.9.3.21])
	by outgoing-exchange-3.mit.edu (8.13.8/8.12.4) with ESMTP id t5C4x7MC000741
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 00:59:08 -0400
Received: from OC11EXCAS21.exchange.mit.edu (18.9.1.46) by
 OC11EXEDGE3.EXCHANGE.MIT.EDU (18.9.3.21) with Microsoft SMTP Server (TLS) id
 14.3.158.1; Fri, 12 Jun 2015 00:59:03 -0400
Received: from OC11EXPO29.exchange.mit.edu ([169.254.1.147]) by
 OC11EXCAS21.exchange.mit.edu ([18.9.1.46]) with mapi id 14.03.0158.001; Fri,
 12 Jun 2015 00:59:07 -0400
Thread-Topic: git_config_set(?) adding and removing creates extraneous lines
Thread-Index: AQHQpMyCpxEi6wsBvU2tbTOSmFpk6w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.217.209.111]
Content-ID: <B9B0176D7107594A985C3D80597C737B@exchange.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsUixCmqrCuTXhVq8H63hUXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDJ23ZrGWNDHVfFtew9TA+Nj9i5GTg4JAROJR98msUDYYhIX7q1n
	62Lk4hASWMwksXL5CxYI5xajxIk/+6Cch4wSc961MoK0CAlsZ5R4ecITIrGaUeLRv6dsIAk2
	AQ2JV3vesHYxcnCICOhL9F0QBQkLC7hLzJ0/H2y1iICPxL83T5khbD2J1UtawVpZBFQlzi36
	DDafV8BKYsfr12A1jEDnfT+1hgnEZhYQl7j1ZD4TxNmCEotm72GGeeHfrodsELaSxPbtu5kh
	6g0k3p+bD2XbSzTP3Qc1R1ti2UKI+bxAc07OfMIygVF8FpIVs5C0z0LSPgtJ+ywk7QsYWVcx
	yqbkVunmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmIER5sk/w7GbweVDjEKcDAq8fAmaFWF
	CrEmlhVX5h5ilORgUhLlnZ8CFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCa2ILlONNSaysSi3K
	h0lJc7AoifNu+sEXIiSQnliSmp2aWpBaBJOV4eBQkuBdkQrUKFiUmp5akZaZU4KQZuLgBBnO
	AzT8H8hi3uKCxNzizHSI/ClGRSlxXmmQZgGQREZpHlwvLBm+YhQHekWY9yZIFQ8wkcJ1vwIa
	zAQ0eCFzOcjgkkSElFQDo8zSb7Uhnb8+njeROmxWZ9hqfHRTQsf6S3Gsa0taJgZ8ftY5z7qh
	9uHH5FsfN74TkTp82uv0y3U5qetOiifNk0v2vltvuN93SfG1I+l/J3ltW/b5f3lN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271470>

Hi all,

This is a very minor bug I noticed (perhaps not even worth fixing becau=
se it=92s not harmful), but I thought that I=92d point it out.

I found that if I used `git branch --edit-description` to add and remov=
e descriptions a couple times, it would accumulate extra lines in my `.=
git/config` instead of removing lines altogether or combining things wh=
ere appropriate.

To reproduce:

    git init
    git commit --allow-empty -m "Initial commit=94
    git branch --edit-description master # and type in some text
    git branch --edit-description master # and remove all the text
    git branch --edit-description master # and type in some text again

Now, when running `tail -n 3 .git/config`, you see:

    [branch "master"]
    [branch "master"]
            description =3D asdf\n

This doesn=92t seem right. And if the steps are repeated, the junk accu=
mulates.
Btw, the output of `git --version` is "git version 2.2.1=94.


Is this something that we want to fix?

If yes, and if someone can point me in the right direction, I=92d be ha=
ppy to try to work on it and send in a patch. I think the issue is in t=
he implementation of `git_config_set` and company, but I haven=92t real=
ly investigated it very deeply.



Regards,
Anish