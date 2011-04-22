From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 22 Apr 2011 15:11:46 -0400
Message-ID: <4DB1D2F2.6040000@mit.edu>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu> <1302274674-4231-1-git-send-email-asedeno@mit.edu> <7vmxk033ic.fsf@alter.siamese.dyndns.org> <20110408205437.GB16540@sigill.intra.peff.net> <7v4o6830cc.fsf@alter.siamese.dyndns.org> <20110408213201.GA20348@sigill.intra.peff.net> <7vipuo1iuy.fsf@alter.siamese.dyndns.org> <20110408224035.GB7343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:11:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDLll-0000Ph-55
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 21:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab1DVTLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2011 15:11:51 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:59240 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1DVTLu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2011 15:11:50 -0400
X-AuditID: 12074422-b7ccdae000003dab-3d-4db1d2f823d2
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 68.DF.15787.8F2D1BD4; Fri, 22 Apr 2011 15:11:52 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p3MJBnBn014757
	for <git@vger.kernel.org>; Fri, 22 Apr 2011 15:11:49 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p3MJBlEv004618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 22 Apr 2011 15:11:49 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id 2F25414C02B; Fri, 22 Apr 2011 15:11:47 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (ita4fw1.itasoftware.com [63.107.91.99])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id CF69614C00F;
	Fri, 22 Apr 2011 15:11:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <20110408224035.GB7343@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYrdT0f1xaaOvwdy7fBZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MrovN7AXnBUt6JhhW4D4yblLkZODgkBE4k3HWuYIWwxiQv31rN1
	MXJxCAnsY5RYPGUflHOKUWLdljdQzicmiRWdnYwgLUICRRLP9y5jhEjsZpR4t+otK0iCV0BN
	4kfbLBYQm0VAVeLnkiawOJuAi8SSx9fYQGxRgXiJ2Z232CDqBSVOznwCVi8iICvx/fBGsKHM
	AosZJdb87ABLCAt4SEw7tpoZYttvJolNJyaDJTgFrCTOnlkOtIEDqENdYv08IZAws4C8RPPW
	2cwTGIVnIdkxC6FqFpKqBYzMqxhlU3KrdHMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MYKD
	20VpB+PPg0qHGAU4GJV4eNPWb/QVYk0sK67MPcQoycGkJMpbfwEoxJeUn1KZkVicEV9UmpNa
	fIhRgoNZSYT38RmgHG9KYmVValE+TEqag0VJnHeOpLqvkEB6YklqdmpqQWoRTFaGg0NJglcH
	GMVCgkWp6akVaZk5JQhpJg5OkOE8QMMngNTwFhck5hZnpkPkTzEqSonz5oEkBEASGaV5cL2w
	5POKURzoFWHecJAqHmDigut+BTSYCWjwnN1gg0sSEVJSDYyFmXt9Cne/7bpsLfwtVdo6rr/8
	n8On0AtP685JXmb6YcI2fZXEpoRTMZnnJmml5jOoO0aILuq48fz5/dmWDotefRFJmP/UeobQ
	i/23jfm7kg6euprZmF1wRZSfwZvjtexp/7wDh++v5WZO+HikvsVcMthk/7tiYW7+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171941>

(Sorry I didn't chime in on this tangent. My life has been very busy si=
nce
Google finished acquiring ITA Software. At least it's a good kind of bu=
sy.
:) )

I'd be happy to see something like this get in. I've often noticed
git-send-email telling me that it couldn't parse an address out of my
signed-of-by lines, but I never stopped and took the time to look into =
it.

-Alejandro

On 04/08/2011 06:40 PM, Jeff King wrote:
> On Fri, Apr 08, 2011 at 03:25:09PM -0700, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>
>>> I disagree. Format-patch claims to make an mbox, so it should make =
one
>>> that is valid.
>>
>> OK.  That makes sense (even though I think it would make cutting and
>> pasting somewhat awkward).
>=20
> Cutting and pasting is already potentially awkward, because we
> rfc2047-quote in format-patch, too. But we can still get away without
> quoting at all in regular "git log". The "Author:" lines, while
> rfc822-looking do not have to be real header lines, and we know that
> everything before the <> must be the name.
>=20
> So I think this is the patch we want:
>=20
> -- >8 --
> Subject: [PATCH] pretty: quote rfc822 specials in email addresses
>=20
> If somebody has a name that includes an rfc822 special, we
> will output it literally in the "From:" header. This is
> usually OK, but certain characters (like ".") are supposed
> to be enclosed in double-quotes in a mail header.
>=20
> In practice, whether this matters may depend on your MUA.
> Some MUAs will happily take in:
>=20
>    From: Foo B. Bar <author@example.com>
>=20
> without quotes, and properly quote the "." when they send
> the actual mail.  Others may not, or may screw up harder
> things like:
>=20
>   From: Foo "The Baz" Bar <author@example.com>
>=20
> For example, mutt will strip the quotes, thinking they are
> actual syntactic rfc822 quotes.
>=20
> So let's quote properly, and then (if necessary) we still
> apply rfc2047 encoding on top of that, which should make all
> MUAs happy.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pretty.c                |   61 +++++++++++++++++++++++++++++++++++++=
+++++++++-
>  t/t4014-format-patch.sh |   42 ++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 1 deletions(-)
>=20
> diff --git a/pretty.c b/pretty.c
> index e1d8a8f..8345485 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -208,6 +208,58 @@ int has_non_ascii(const char *s)
>  	return 0;
>  }
> =20
> +static int is_rfc822_special(char ch)
> +{
> +	switch (ch) {
> +	case '(':
> +	case ')':
> +	case '<':
> +	case '>':
> +	case '[':
> +	case ']':
> +	case ':':
> +	case ';':
> +	case '@':
> +	case ',':
> +	case '.':
> +	case '"':
> +	case '\\':
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int has_rfc822_specials(const char *s, int len)
> +{
> +	int i;
> +	for (i =3D 0; i < len; i++)
> +		if (is_rfc822_special(s[i]))
> +			return 1;
> +	return 0;
> +}
> +
> +static void add_rfc822_quoted(struct strbuf *out, const char *s, int=
 len)
> +{
> +	int i;
> +
> +	/* just a guess, we may have to also backslash-quote */
> +	strbuf_grow(out, len + 2);
> +
> +	strbuf_addch(out, '"');
> +	for (i =3D 0; i < len; i++) {
> +		switch (s[i]) {
> +		case '"':
> +		case '\\':
> +			strbuf_addch(out, '\\');
> +			/* fall through */
> +		default:
> +			strbuf_addch(out, s[i]);
> +		}
> +	}
> +	strbuf_addch(out, '"');
> +}
> +
>  static int is_rfc2047_special(char ch)
>  {
>  	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (c=
h =3D=3D '_'));
> @@ -293,7 +345,14 @@ void pp_user_info(const char *what, enum cmit_fm=
t fmt, struct strbuf *sb,
>  			name_tail--;
>  		display_name_length =3D name_tail - line;
>  		strbuf_addstr(sb, "From: ");
> -		add_rfc2047(sb, line, display_name_length, encoding);
> +		if (has_rfc822_specials(line, display_name_length)) {
> +			struct strbuf quoted =3D STRBUF_INIT;
> +			add_rfc822_quoted(&quoted, line, display_name_length);
> +			add_rfc2047(sb, quoted.buf, quoted.len, encoding);
> +			strbuf_release(&quoted);
> +		}
> +		else
> +			add_rfc2047(sb, line, display_name_length, encoding);
>  		strbuf_add(sb, name_tail, namelen - display_name_length);
>  		strbuf_addch(sb, '\n');
>  	} else {
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index c3cdb52..dd406c4 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -793,4 +793,46 @@ test_expect_success 'format-patch wraps extremel=
y long headers (rfc2047)' '
>  	test_cmp expect subject
>  '
> =20
> +check_author() {
> +	echo content >>file &&
> +	git add file &&
> +	GIT_AUTHOR_NAME=3D$1 git commit -m author-check &&
> +	git format-patch --stdout -1 >patch &&
> +	grep ^From: patch >actual &&
> +	test_cmp expect actual
> +}
> +
> +cat >expect <<'EOF'
> +From: "Foo B. Bar" <author@example.com>
> +EOF
> +test_expect_success 'format-patch quotes dot in headers' '
> +	check_author "Foo B. Bar"
> +'
> +
> +cat >expect <<'EOF'
> +From: "Foo \"The Baz\" Bar" <author@example.com>
> +EOF
> +test_expect_success 'format-patch quotes double-quote in headers' '
> +	check_author "Foo \"The Baz\" Bar"
> +'
> +
> +cat >expect <<'EOF'
> +From: =3D?UTF-8?q?"F=3DC3=3DB6o=3D20B.=3D20Bar"?=3D <author@example.=
com>
> +EOF
> +test_expect_success 'rfc2047-encoded headers also double-quote 822 s=
pecials' '
> +	check_author "F=C3=B6o B. Bar"
> +'
> +
> +cat >expect <<'EOF'
> +Subject: header with . in it
> +EOF
> +test_expect_success 'subject lines do not have 822 atom-quoting' '
> +	echo content >>file &&
> +	git add file &&
> +	git commit -m "header with . in it" &&
> +	git format-patch -k -1 --stdout >patch &&
> +	grep ^Subject: patch >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
