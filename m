From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: svn propset - focus on svn:externals
Date: Wed, 29 Sep 2010 10:12:05 +0200
Organization: FutureLAB
Message-ID: <4CA2F4D5.6010601@futurelab.ch>
References: <4C9115E9.4080900@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms080801080003080603040900"
Cc: git@vger.kernel.org
To: schachtobi <schachtobi@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 29 10:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0sPe-00056j-Bm
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 10:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0I2IxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 04:53:13 -0400
Received: from host-179.futurelab.ch ([62.2.169.179]:47156 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab0I2IxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 04:53:12 -0400
X-Greylist: delayed 2464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2010 04:53:11 EDT
Received: from astricker.local (primus [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id o8T8C5Vk002245;
	Wed, 29 Sep 2010 10:12:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4C9115E9.4080900@web.de>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157547>

This is a cryptographically signed message in MIME format.

--------------ms080801080003080603040900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

schachtobi wrote:
> * svn:externals (not yet supported? Found nothing so far)
>   except solutions here:
>
http://panthersoftware.com/articles/view/3/svn-s-svn-externals-to-git-s-s=
ubmodule-for-rails-plugins
>   but this is not the same since the client has to setup the links,
> repositories etc. And they do not come automatically as in subversion.

Then there is also the git-svn-clone-externals [1]

>   I guess submodules is the proper replacement. But still having the
> svn:externals from a pull this could be done automatically without the
> need for scripting. And the dcommit should also work for the submodules=
=2E

Git submodules could help here, but I doubt there is a full automated
solution that will work in all circumstances. Here at work we have an
excessive use of svn:externals that points diagonally through the whole
repository.

> for me the svn:merginfo and the svn:externals would be most benifitial
> since our team uses this a lot and without being able to set those from=

> git it will be not possible for me to use git for a svn client to do th=
e
> merges.

For me the support for the new svn:externals syntax [2] would be a first
huge step forwards. With the proper support for the new syntax I may use
the git-svn-clone-externals [1] to fetch the externals.

I started to extend git-svn to support those new syntax and pushed
it to github [3] for those who are interested. I'm a bit busy at the
moment, but like to continue this work.

Regards, Andy

[1] http://github.com/andrep/git-svn-clone-externals
[2] http://subversion.apache.org/docs/release-notes/1.5.html#externals
[3] http://github.com/AndyStricker/git#



--------------ms080801080003080603040900
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
0cz5EPcjMRFhHaOjmKjT/LXpFo24fcnGqRYtVE2EJ1GIbwzFGawfhTVgz/UdpwIoX9UlLAL/
MNXsoA0SJzGCA9MwggPPAgEBMIGVMIGOMQswCQYDVQQGEwJDSDEPMA0GA1UECBMGWnVyaWNo
MRMwEQYDVQQHEwpXaW50ZXJ0aHVyMRUwEwYDVQQKEwxmdXR1cmVMQUIgQUcxHDAaBgNVBAMT
E1NpZ25pbmcgRGVwYXJ0ZW1lbnQxJDAiBgkqhkiG9w0BCQEWFXN5c2FkbWluQGZ1dHVyZWxh
Yi5jaAICARIwCQYFKw4DAhoFAKCCAhIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTAwOTI5MDgxMjA1WjAjBgkqhkiG9w0BCQQxFgQUnbZDDBxj/VeHvUKQ
2ViJeTcCG18wXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGm
BgkrBgEEAYI3EAQxgZgwgZUwgY4xCzAJBgNVBAYTAkNIMQ8wDQYDVQQIEwZadXJpY2gxEzAR
BgNVBAcTCldpbnRlcnRodXIxFTATBgNVBAoTDGZ1dHVyZUxBQiBBRzEcMBoGA1UEAxMTU2ln
bmluZyBEZXBhcnRlbWVudDEkMCIGCSqGSIb3DQEJARYVc3lzYWRtaW5AZnV0dXJlbGFiLmNo
AgIBEjCBqAYLKoZIhvcNAQkQAgsxgZiggZUwgY4xCzAJBgNVBAYTAkNIMQ8wDQYDVQQIEwZa
dXJpY2gxEzARBgNVBAcTCldpbnRlcnRodXIxFTATBgNVBAoTDGZ1dHVyZUxBQiBBRzEcMBoG
A1UEAxMTU2lnbmluZyBEZXBhcnRlbWVudDEkMCIGCSqGSIb3DQEJARYVc3lzYWRtaW5AZnV0
dXJlbGFiLmNoAgIBEjANBgkqhkiG9w0BAQEFAASCAQB04Qj5jCTK0E+gT2XGMb9ZaKMnmVz0
kcjUmeopaDZe/Y4vAxcdqUXyDmZyeVBcSHda/zJ3cNcyaYK0lGdkg/DYtx7NsjpYW9vrCuPR
4Wst4Q0vBB9oWPJECUlavQh9QOZKpPQNoq56xuxPhh6cR6drd+BI2YXDno6Ys/N6OqD4Z1Kz
Oaf35+GlVT+T+wR+cuhap9Fa8LzZ56IBRxkrhYPpG79pRTI+VZ2KDN0FX4ziMuB6Li7Lt5fA
SGanlvKQObdUg7mowNLA0PTSJk3sgm0Y7QobfuJ3cfxMs7Fa5pezpSW+HuHFepsRAX92SRv4
DIYEzIbQ2OyB70v7863I8bvmAAAAAAAA
--------------ms080801080003080603040900--
