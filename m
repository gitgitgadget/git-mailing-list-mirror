From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] contrib: add win32 credential-helper
Date: Fri, 22 Jun 2012 18:29:34 +0200
Message-ID: <CABPQNSZLVuDKi0k0fhW+WyvCG_ShDETt_0i+BnmDUUE_su9Suw@mail.gmail.com>
References: <1334861122-3144-1-git-send-email-kusmabite@gmail.com> <20120424204052.GC21904@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncCOPdven-DxCYu5L_BBoEziONrA@googlegroups.com Fri Jun 22 18:30:17 2012
Return-path: <msysgit+bncCOPdven-DxCYu5L_BBoEziONrA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCYu5L_BBoEziONrA@googlegroups.com>)
	id 1Si6kS-0004xZ-Vd
	for gcvm-msysgit@m.gmane.org; Fri, 22 Jun 2012 18:30:17 +0200
Received: by obbta17 with SMTP id ta17sf1417786obb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 22 Jun 2012 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=YgUkSeAL+UFKL8aoflhqfSjvHg+B1nOBiS6x2XcYxkA=;
        b=KDLD7ukigDcFpBPSS/nX2CgdQVWFp3Z7LKKENB4wdHsJkmoGWFKY5q7GfzMJUZBbsJ
         Fp2p6OYqE3rlG3CovQpTMgEpFpvqSUHUv+AMA6hO1ZMa8lMdp+EJf6j/INlvHvbNFOLy
         6n/3rV9m33ZftKmhydCpdK3lfHVmeGm/2Eh0s=
Received: by 10.68.242.106 with SMTP id wp10mr35407pbc.3.1340382616272;
        Fri, 22 Jun 2012 09:30:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.240.165 with SMTP id wb5ls6558517pbc.1.gmail; Fri, 22 Jun
 2012 09:30:14 -0700 (PDT)
Received: by 10.68.190.104 with SMTP id gp8mr3934150pbc.4.1340382614678;
        Fri, 22 Jun 2012 09:30:14 -0700 (PDT)
Received: by 10.68.190.104 with SMTP id gp8mr3934148pbc.4.1340382614668;
        Fri, 22 Jun 2012 09:30:14 -0700 (PDT)
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com [209.85.160.49])
        by gmr-mx.google.com with ESMTPS id ph6si96458pbc.2.2012.06.22.09.30.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 09:30:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.49 as permitted sender) client-ip=209.85.160.49;
Received: by pbbrq13 with SMTP id rq13so4040494pbb.36
        for <msysgit@googlegroups.com>; Fri, 22 Jun 2012 09:30:14 -0700 (PDT)
Received: by 10.68.197.70 with SMTP id is6mr11784034pbc.64.1340382614473; Fri,
 22 Jun 2012 09:30:14 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Fri, 22 Jun 2012 09:29:34 -0700 (PDT)
In-Reply-To: <20120424204052.GC21904@sigill.intra.peff.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.49 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200446>

On Tue, Apr 24, 2012 at 10:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 19, 2012 at 08:45:22PM +0200, Erik Faye-Lund wrote:
>
>> Here's an updated version of my Windows credential-helper.
>>
>> The most important difference is that it doesn't suck as much as
>> it used to ;)
>>
>> Basically, I'm now using the attribute-system to store the meta-data
>> for the credentials.
>>
>> This passes the test for me, and seems to work OK.
>
> This looks much better. As usual, I can't comment on the Windows-y
> parts, but the credential logic looks good. One minor comment:
>
>> +int main(int argc, char *argv[])
>> +{
>> [...]
>> + =A0 =A0 if (!protocol || !host)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> You could have a protocol that does not have a "host" component. Git
> will produce this for a cached certificate password (which will then
> always have a "path" field). I don't know if anybody is using it to
> cache certificate passwords, and I admit that it is not very well tested
> by me, either. So I'm not sure anybody will actually care.
>
> The credential-store helper uses this logic:
>
> =A0$ sed -n '70,79p' credential-store.c
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Sanity check that what we are storing is actually sensi=
ble.
> =A0 =A0 =A0 =A0 * In particular, we can't make a URL without a protocol f=
ield.
> =A0 =A0 =A0 =A0 * Without either a host or pathname (depending on the sch=
eme),
> =A0 =A0 =A0 =A0 * we have no primary key. And without a username and pass=
word,
> =A0 =A0 =A0 =A0 * we are not actually storing a credential.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (!c->protocol || !(c->host || c->path) ||
> =A0 =A0 =A0 =A0 =A0 =A0!c->username || !c->password)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> I'm pretty sure the OS X helper does not handle certificate passwords at
> all. It is harder there, because I map directly to native protocol
> types, and I haven't checked to see whether OS X handles this type.

Right. I copied this logic from the OSX helper.

> But
> since you are just storing whatever protocol information git hands you,
> I think for you it is just a matter of letting it through (and handling
> the "!host" case when writing).

Yeah, I agree. This on top should do it:

diff --git a/contrib/credential/wincred/git-credential-wincred.c
b/contrib/credential/wincred/git-credential-wincred.c
index e63575f..cbaec5f 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -232,16 +232,20 @@ static void store_credential(void)
 	cred.CredentialBlobSize =3D auth_buf_size;
 	cred.CredentialBlob =3D auth_buf;
 	cred.Persist =3D CRED_PERSIST_LOCAL_MACHINE;
-	cred.AttributeCount =3D 2;
+	cred.AttributeCount =3D 1;
 	cred.Attributes =3D attrs;
 	cred.TargetAlias =3D NULL;
 	cred.UserName =3D wusername;

 	write_attr(attrs, L"git_protocol", protocol);
-	write_attr(attrs + 1, L"git_host", host);
+
+	if (host) {
+		write_attr(attrs + cred.AttributeCount, L"git_host", host);
+		cred.AttributeCount++;
+	}

 	if (path) {
-		write_attr(attrs + 2, L"git_path", path);
+		write_attr(attrs + cred.AttributeCount, L"git_path", path);
 		cred.AttributeCount++;
 	}

@@ -322,7 +326,7 @@ int main(int argc, char *argv[])

 	load_cred_funcs();

-	if (!protocol || !host)
+	if (!protocol || !(host || path))
 		return 0;

 	/* prepare 'target', the unique key for the credential */
@@ -333,7 +337,8 @@ int main(int argc, char *argv[])
 		strncat(target_buf, username, sizeof(target_buf));
 		strncat(target_buf, "@", sizeof(target_buf));
 	}
-	strncat(target_buf, host, sizeof(target_buf));
+	if (host)
+		strncat(target_buf, host, sizeof(target_buf));
 	if (path) {
 		strncat(target_buf, "/", sizeof(target_buf));
 		strncat(target_buf, path, sizeof(target_buf));

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
