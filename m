From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 12:15:09 -0700
Message-ID: <7vboyorm4i.fsf@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 21:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ2VJ-0006UM-Q3
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 21:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1E0TPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 15:15:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1E0TPT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 15:15:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D8B0433A;
	Fri, 27 May 2011 15:17:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Tj3+J+1CDSjL
	3/BL3bvwP6bygAw=; b=ON8OMmoMp5oZz4q3OtAoWOhKKHmNbRE80ppwRuJk8zlY
	BcZsAtgIMK0BvHHmKqTad5gLJBIUHjJfGrUcPa/9sFYWK6ogbTfB0pB5Lz8rhG8Q
	aKt1fazgl3Y7DWDdyQUlqwS/TmhscnIXr9VdhycyXBj4FN4BU226kfEN4Ri4ZBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ptyv0n
	uVsJRz4uwuGafO44pDCID495luNOeFgAH60UtjQ9L/RZS6/YR4oSxDQr+DJIA51r
	zSZyDYGDIcOHFndk9rlOOJ/VL109EnFItLbqdV612uD4yu19IluwOsEqfHDsgHhc
	HV+e8hMcIrAr5EKDRmrktzDB2BMqGogb0dNNI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24CD24332;
	Fri, 27 May 2011 15:17:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA7E84330; Fri, 27 May 2011
 15:17:17 -0400 (EDT)
In-Reply-To: <7vipswro57.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 May 2011 11:31:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F279852C-8895-11E0-8F00-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174639>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Now, very arguably this is not a git issue at all. Having the odd nb=
sp
>> be more visible in my other tools would have been fine - either 'les=
s'
>> showing it (the way it shows other control characters) or my termina=
l
>> making some visual distinction. That said, I think it's something th=
at
>> git could perhaps protect against a bit.
>
> Yeah. I would have expected that "git log -p" would at least show aft=
er
> the fact, relying on "less" being aware about it, but that does not s=
eem
> to be the case.  Setting my pager to "cat -e" is the only workaround =
I can
> think of right now (shows "M-BM- " there), but of course that wouldn'=
t be
> practical at all. We want to notice this during patch application.

The "diff" side would look like this.  I am tempted to change all the
"char *line" to "unsigned char *line", before updating "apply", though.=
=2E.

 .gitattributes |    2 +-
 ws.c           |   75 ++++++++++++++++++++++++++++++++++++++++++++++++=
++------
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 5e98806..b4459b0 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,3 @@
 * whitespace=3D!indent,trail,space
-*.[ch] whitespace=3Dindent,trail,space
+*.[ch] whitespace=3Dindent,trail,space,nbsp
 *.sh whitespace=3Dindent,trail,space
diff --git a/ws.c b/ws.c
index 01762cc..4766d6f 100644
--- a/ws.c
+++ b/ws.c
@@ -20,7 +20,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
-	{ "nbsp", WS_NSBP, 0, 0 },
+	{ "nbsp", WS_NBSP, 0, 0 },
 };
=20
 unsigned parse_whitespace_rule(const char *string)
@@ -147,6 +147,49 @@ char *whitespace_error_string(unsigned ws)
 	return strbuf_detach(&err, NULL);
 }
=20
+static inline int is_nbsp(const char *at_)
+{
+	const unsigned char *at =3D (const unsigned char *)at_;
+	return at[0] =3D=3D 0xc2 && at[1] =3D=3D 0xa0;
+}
+
+/*
+ * Show line while highlighting nbsp "=C2=A0" (c2a0) if ws is set
+ */
+static void emit_with_nbsp_hilite(FILE *stream,
+				  const char *set, const char *reset,
+				  const char *ws,
+				  const char *line, int len)
+{
+	if (!len)
+		return;
+	while (len) {
+		int ok; /* leading segment without problematic nbsp */
+		if (!ws) {
+			ok =3D len;
+		} else {
+			for (ok =3D 0; ok < len; ok++) {
+				if (ok < len - 1 && is_nbsp(line + ok))
+					break;
+			}
+		}
+		if (ok) {
+			fputs(set, stream);
+			fwrite(line, ok, 1, stream);
+			fputs(reset, stream);
+		}
+		line +=3D ok;
+		len -=3D ok;
+		if (len) {
+			fputs(ws, stream);
+			fwrite(line, 2, 1, stream);
+			fputs(reset, stream);
+			line +=3D 2;
+			len -=3D 2;
+		}
+	}
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws=
_rule,
 				FILE *stream, const char *set,
@@ -170,6 +213,24 @@ static unsigned ws_check_emit_1(const char *line, =
int len, unsigned ws_rule,
 		len--;
 	}
=20
+	/* Check for nbsp in UTF-8 (c2a0) */
+	if (ws_rule & WS_NBSP) {
+		for (i =3D 1; i < len; i++) {
+			switch (line[i] & 0xff) {
+			case 0xc2:
+				break;
+			case 0xa0:
+				if ((line[i-1] & 0xff) =3D=3D 0xc2) {
+					result |=3D WS_NBSP;
+					continue;
+				}
+				/* fallthru */
+			default:
+				i++;
+			}
+		}
+	}
+
 	/* Check for trailing whitespace. */
 	if (ws_rule & WS_BLANK_AT_EOL) {
 		for (i =3D len - 1; i >=3D 0; i--) {
@@ -230,13 +291,11 @@ static unsigned ws_check_emit_1(const char *line,=
 int len, unsigned ws_rule,
 		 * The non-highlighted part ends at "trailing_whitespace".
 		 */
=20
-		/* Emit non-highlighted (middle) segment. */
-		if (trailing_whitespace - written > 0) {
-			fputs(set, stream);
-			fwrite(line + written,
-			    trailing_whitespace - written, 1, stream);
-			fputs(reset, stream);
-		}
+		/* Emit middle segment, highlighting nbsp as needed */
+		emit_with_nbsp_hilite(stream, set, reset,
+				      (result & WS_NBSP) ? ws : NULL,
+				      line + written,
+				      trailing_whitespace - written);
=20
 		/* Highlight errors in trailing whitespace. */
 		if (trailing_whitespace !=3D len) {
