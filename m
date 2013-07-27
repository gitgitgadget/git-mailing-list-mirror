From: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: Re: [PATCH] imap-send: use Apple's Security framework for base64
 encoding
Date: Sat, 27 Jul 2013 16:28:06 -0700
Message-ID: <1206359C-E833-42D6-87C5-11C17BA6FCC4@apple.com>
References: <1374957092-41505-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CB87D58B-E456-4DE6-ABB2-C3D856F72547";
 protocol="application/pkcs7-signature"; micalg=sha1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 02:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3Eri-0008OH-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 02:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab3G1A3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 20:29:16 -0400
Received: from mail-out.apple.com ([17.151.62.49]:34894 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3G1A3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 20:29:15 -0400
X-Greylist: delayed 3669 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jul 2013 20:29:15 EDT
Received: from relay2.apple.com ([17.128.113.67])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0MQM004QZBUQG920@mail-out.apple.com> for git@vger.kernel.org;
 Sat, 27 Jul 2013 16:28:05 -0700 (PDT)
X-AuditID: 11807143-b7fb46d00000227e-2c-51f4578515fa
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)	by relay2.apple.com (Apple SCV relay)
 with SMTP id 48.CB.08830.58754F15; Sat, 27 Jul 2013 16:28:05 -0700 (PDT)
Received: from [17.153.42.219] (unknown [17.153.42.219])
 by koseret.apple.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPSA id <0MQM006PGBUSWY00@koseret.apple.com> for git@vger.kernel.org;
 Sat, 27 Jul 2013 16:28:05 -0700 (PDT)
In-reply-to: <1374957092-41505-1-git-send-email-davvid@gmail.com>
X-Mailer: Apple Mail (2.1789)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsUiON1OXbc1/EugwYGDehZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MqY1PmKsWBRWMXWSWuYGxhb/boYOTgkBEwk7v1V6GLkBDLFJC7c
	W8/WxcjFISTQwiTxdt0LdghnMZPE4g/TmEGqmAWmMEqs6EwHsXkF9CSeHz7EBGILC4RI3Fz3
	gB3EZgMaeuvPaRYQm1PAUeL1hY9gNSwCqhJL244wQcxJk2g+/ZAV5AheARuJ1sdyIGEhAQeJ
	Tb3bwUpEBFQkdl6+yAZxnKzEvG3/mCYw8s9CcsUsJFdAxLUlli18zTwLaCqzgI7E5IWMEGFT
	iSdvt7NB2NYSP+c8goorSkzpfsi+gJF9FaNAUWpOYqWRXmJBQU6qXnJ+7iZGUOg2FDrvYDy2
	zOoQowAHoxIPr4Xrl0Ah1sSy4srcQ4wqQCMebVh9gVGKJS8/L1VJhHf68c+BQrwpiZVVqUX5
	8UWlOanFhxilOViUxHk9Mj8ECgmkJ5akZqemFqQWwWSZODilGhjNrSNt39YX9zw/tvfo1PsS
	/11f/Nry0ttKsNSzW0h44kvlh48v/ubsquw6tHbr5b0bP3ezbvB57fvEUvx1tcSO6XbbOmMn
	CQUc39jJvePS2e6nbh+u5O2qyv2xYLn0NI0zG/uUNmf87WZYGfzkKodea2665H3LE1OPLY9s
	/nXTY/nrBVY7vavNlFiKMxINtZiLihMBFsRMEGUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231257>


--Apple-Mail=_CB87D58B-E456-4DE6-ABB2-C3D856F72547
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi David,

Thanks for massaging it to apply to master and cleaning up the style =
conflicts.

On Jul 27, 2013, at 13:31, David Aguilar <davvid@gmail.com> wrote:

> From: Jeremy Huddleston <jeremyhu@apple.com>
>=20
> Use Apple's supported functions for base64 encoding instead
> of the deprecated OpenSSL functions.
>=20
> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is Jeremy's original patch rebased onto the latest master.
>=20
> Jeremy, the only way I could get this to work was to suppress =
inclusion of
> openssl/sha.h by defining HEADER_SHA_H.  This can be removed when we =
have
> replacements for openssl/x509v3.h.
>=20
> Makefile    |  1 +
> imap-send.c | 85 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 82 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 0600eb4..4c40665 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1413,6 +1413,7 @@ ifdef PPC_SHA1
> 	LIB_H +=3D ppc/sha1.h
> else
> ifdef APPLE_COMMON_CRYPTO
> +	LIB_4_CRYPTO +=3D -framework Security -framework CoreFoundation
> 	COMPAT_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
> 	SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
> else
> diff --git a/imap-send.c b/imap-send.c
> index d6b65e2..3fd9c0e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,14 +22,11 @@
>  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  =
02111-1307  USA
>  */
>=20
> -#include "cache.h"
> -#include "exec_cmd.h"
> -#include "run-command.h"
> -#include "prompt.h"
> #ifdef NO_OPENSSL
> typedef void *SSL;
> #else
> #ifdef APPLE_COMMON_CRYPTO
> +/* git-compat-util.h overwrites ctype.h; this must be included first =
*/
> #include <CommonCrypto/CommonHMAC.h>
> #define HMAC_CTX CCHmacContext
> #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, =
len)
> @@ -37,12 +34,23 @@ typedef void *SSL;
> #define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> #define HMAC_CTX_cleanup(ignore)
> #define EVP_md5() kCCHmacAlgMD5
> +
> +#if __MAC_OS_X_VERSION_MIN_REQUIRED >=3D 1070
> +#define APPLE_LION_OR_NEWER
> +#include <Security/Security.h>
> +#define HEADER_SHA_H /* suppress inclusion of openssl/sha.h */
> +#endif
> +
> #else
> #include <openssl/evp.h>
> #include <openssl/hmac.h>
> #endif
> #include <openssl/x509v3.h>
> #endif
> +#include "cache.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "prompt.h"
>=20
> static const char imap_send_usage[] =3D "git imap-send < <mbox>";
>=20
> @@ -877,6 +885,75 @@ static void imap_close_store(struct imap_store =
*ctx)
> 	free(ctx);
> }
>=20
> +#ifdef APPLE_LION_OR_NEWER
> +#define EVP_DecodeBlock git_CC_EVP_DecodeBlock
> +#define EVP_EncodeBlock git_CC_EVP_EncodeBlock
> +#define error_check(pattern, err) \
> +	do { \
> +		if (err) { \
> +			die(pattern, (long)CFErrorGetCode(err)); \
> +		} \
> +	} while(0)
> +
> +static int git_CC_EVP_EncodeBlock(unsigned char *out,
> +		const unsigned char *in, int inlen)
> +{
> +	CFErrorRef err;
> +	SecTransformRef encoder;
> +	CFDataRef input, output;
> +	CFIndex length;
> +
> +	encoder =3D SecEncodeTransformCreate(kSecBase64Encoding, &err);
> +	error_check("SecEncodeTransformCreate failed: %ld", err);
> +
> +	input =3D CFDataCreate(kCFAllocatorDefault, in, inlen);
> +	SecTransformSetAttribute(encoder, =
kSecTransformInputAttributeName,
> +			input, &err);
> +	error_check("SecTransformSetAttribute failed: %ld", err);
> +
> +	output =3D SecTransformExecute(encoder, &err);
> +	error_check("SecTransformExecute failed: %ld", err);
> +
> +	length =3D CFDataGetLength(output);
> +	CFDataGetBytes(output, CFRangeMake(0, length), out);
> +
> +	CFRelease(output);
> +	CFRelease(input);
> +	CFRelease(encoder);
> +
> +	return (int)strlen((const char *)out);
> +}
> +
> +static int git_CC_EVP_DecodeBlock(unsigned char *out,
> +		const unsigned char *in, int inlen)
> +{
> +	CFErrorRef err;
> +	SecTransformRef decoder;
> +	CFDataRef input, output;
> +	CFIndex length;
> +
> +	decoder =3D SecDecodeTransformCreate(kSecBase64Encoding, &err);
> +	error_check("SecEncodeTransformCreate failed: %ld", err);
> +
> +	input =3D CFDataCreate(kCFAllocatorDefault, in, inlen);
> +	SecTransformSetAttribute(decoder, =
kSecTransformInputAttributeName,
> +			input, &err);
> +	error_check("SecTransformSetAttribute failed: %ld", err);
> +
> +	output =3D SecTransformExecute(decoder, &err);
> +	error_check("SecTransformExecute failed: %ld", err);
> +
> +	length =3D CFDataGetLength(output);
> +	CFDataGetBytes(output, CFRangeMake(0, length), out);
> +
> +	CFRelease(output);
> +	CFRelease(input);
> +	CFRelease(decoder);
> +
> +	return (int)strlen((const char *)out);
> +}
> +#endif /* APPLE_LION_OR_NEWER */
> +
> #ifndef NO_OPENSSL
>=20
> /*
> --=20
> 1.8.3.2.804.g0da7a53.dirty
>=20


--Apple-Mail=_CB87D58B-E456-4DE6-ABB2-C3D856F72547
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMezCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIGPzCCBSeg
AwIBAgIDBfQJMA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTMwMjE0MjMxOTE3WhcNMTQwMjE2MTE1MDMyWjBbMRkwFwYDVQQNExAxUVdxcVVpMDM4akNJNjFn
MRswGQYDVQQDDBJqZXJlbXlodUBhcHBsZS5jb20xITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGFw
cGxlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNXcBKUXy6NXfdfBm3YDsnN
sZUBAZ8vr33/Kvo4+kPD8EOGq0LBL4g5r+habwQLBVqgOhNu0EED9VCRBUZNBLJNR1PfBM6uq0O+
pT/FBRB+SRsU1XMX+jt/KLfXCP6Hn9oeLSVzeSIlzd3Br+B9CWXGNjxmH1vL/UBod8uHxxLROo9D
s571b+P0loxBhU6nO7HCVptmxiiRkKiBg9MMdZNyfJ/KzuKp9LXXldsKIB1Y1LCnfHXZBv5JRmEG
923PEcnyRsL3yJ4SphW2PmqUMX52Lkq/krv4XqkFl+h9/EazQPE/ZHlg5lXYIQtfoTpNimN2j9eD
RENyNHVs1VLl+bcCAwEAAaOCAtgwggLUMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUx1VzKpzWhoOIJzYm9M0VPPHHbwEwHwYD
VR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHQYDVR0RBBYwFIESamVyZW15aHVAYXBwbGUu
Y29tMIIBTAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0
Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBp
c3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBw
dXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMDYG
A1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4G
CCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MxL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2Vy
dHMvc3ViLmNsYXNzMS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRz
c2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEASDGjzbcC5ZuYswFmMum7uQyoLX1BQx4KRSIVKvrr
wwX3vX0lDuC/R5m1CmVJR0kw//oPw8smN/kDPTe2yUTrE9E3xwH462aPK1/pKeZIpg7Fo82CYmYV
GMDFYCoarzUPK/mwlxmvO0w6X8GyXC89s7nYHpWNmrvirAN0I8kghLaRYbkcug0SM33j9C60AP19
Fnsv2RwOw5UMI791TeKuPlTV1izHTMm1POBCu3TIWs58MGvDgMO+0xe0jlHNdMDlr7PGs33wyCeF
o/R0Nz3rN2CjWZVVrcH/M+AUsFX7xA0XNo1s6rxNeC9ncu8McbpI56AUJJJUtjbRIgdbyEKnnjGC
A28wggNrAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkG
A1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwX0CTAJBgUrDgMCGgUA
oIIBrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMzA3MjcyMzI4
MDZaMCMGCSqGSIb3DQEJBDEWBBSjCLTogSRKy7N1/t1ZrObdlBMp/jCBpQYJKwYBBAGCNxAEMYGX
MIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2Vj
dXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3Mg
MSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwX0CTCBpwYLKoZIhvcNAQkQAgsxgZeg
gZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1
cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAx
IFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQIDBfQJMA0GCSqGSIb3DQEBAQUABIIBABN0
BGKXu9rmLtNf3A1q0eA70qdyr9a3zQgyTb+Cfnd7RREP3OsIA8M8SLiPUDKf8Nsbvsc4Kg/MyMs/
8B5hs3/ZKIgOXkrpiVRJjwbbczfEGDDShpb+pzbqb/PkiSFcWSlwbHYzqmeUID0stvjvjZrCB8vS
bUI2DVOUFDPLh9vOReyXsSqQAX+AIdZuzH9LkKbPXatpwOLGCKXPYHyz1PHmizaWAZXOJDJljvG9
mjLKsZR4Xxn4CgrN6XXV/WPMgMCuBhOXSVmCsKFa34nmltd0nJrSVU2+5AGlAOTO9/6xnjfxChn2
K2FGviGqL+JO6X5Ob0Zvwm3Je0LiO0ZuERAAAAAAAAA=

--Apple-Mail=_CB87D58B-E456-4DE6-ABB2-C3D856F72547--
