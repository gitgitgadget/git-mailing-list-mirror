From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 04/12] wildmatch: remove unnecessary functions
Date: Wed, 10 Oct 2012 17:38:29 +0200
Message-ID: <50759675.1070108@alum.mit.edu>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com> <1349865651-31889-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLyNA-00042O-2K
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 17:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab2JJPim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 11:38:42 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:62515 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754139Ab2JJPic (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 11:38:32 -0400
X-AuditID: 12074414-b7f846d0000008b8-ed-50759677781d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 50.30.02232.77695705; Wed, 10 Oct 2012 11:38:31 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9AFcT2s000595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2012 11:38:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1349865651-31889-5-git-send-email-pclouds@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqFs+rTTA4O8JHouuK91MFg29V5gt
	uqe8ZXRg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf8XpFdsJqj4kD3XJYGxsds
	XYycHBICJhKLV29kh7DFJC7cWw8U5+IQErjMKPHl/QVGCOc4k8SS3/fAOngFtCXan31hArFZ
	BFQluu9OYgax2QR0JRb1NIPFRQVCJGZcnswMUS8ocXLmExYQW0TAQ+LHzs2sIDazgLXE7j6I
	uLCAq8TR03cZQWwhgXKJY38+gl3EKeAk8WXybqA4B1C9usT6eUIQrfISzVtnM09gFJiFZMMs
	hKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJW5EdjEdOyh1i
	FOBgVOLhlYwvCRBiTSwrrsw9xCjJwaQkyntiUmmAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe
	Ux+gHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBK/qVKBGwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCUxhcD4xQkxQO01xeknbe4IDEXKArReopRl+Nj
	47yHjEIsefl5qVLivK4gRQIgRRmleXArYEnqFaM40MfCvP4gVTzABAc36RXQEiagJTKTSkCW
	lCQipKQaGFMU0+p/NGnujEvi85xxbcH9mRNP7b//Z/I5T6nOTxJOXl0zn6eJZySl80o+eZfP
	VcS9fiHrod37pt0+fS21u82qf1bZ6YBau6+R3uyCn1J23ZFiuLgzdvf+glzxZzWL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207416>

On 10/10/2012 12:40 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wildmatch.c | 161 ++++----------------------------------------------=
----------
>  wildmatch.h |   2 -
>  2 files changed, 9 insertions(+), 154 deletions(-)
>=20
> diff --git a/wildmatch.c b/wildmatch.c
> index f3a1731..71dba76 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -53,33 +53,19 @@
>  #define ISUPPER(c) (ISASCII(c) && isupper(c))
>  #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
> =20
> -#ifdef WILD_TEST_ITERATIONS
> -int wildmatch_iteration_count;
> -#endif
> -
>  static int force_lower_case =3D 0;
> =20
>  /* Match pattern "p" against the a virtually-joined string consistin=
g
>   * of "text" and any strings in array "a". */
> -static int dowild(const uchar *p, const uchar *text, const uchar*con=
st *a)
> +static int dowild(const uchar *p, const uchar *text)

The comment still refers to array "a".

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
