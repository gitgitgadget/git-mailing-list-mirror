From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 11:39:45 +0200
Message-ID: <94a0d4530903240239u5fed58fao350f33b2f2f29044@mail.gmail.com>
References: <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
	 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
	 <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903240052x2c6b882aub7de6d46e9949ddb@mail.gmail.com>
	 <20090324081846.GB660@coredump.intra.peff.net>
	 <94a0d4530903240157v2b9aa91dh4c731b77de9d7b58@mail.gmail.com>
	 <20090324090014.GA2075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm38S-0001Ac-6P
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbZCXJju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 05:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757934AbZCXJjt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:39:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:17753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZCXJjs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 05:39:48 -0400
Received: by fg-out-1718.google.com with SMTP id 16so515149fgg.17
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mxqbv/Ye2P9efdYqJrFdoTMV6wEdHF9o6fEVVu/UXNM=;
        b=e8XiY9ROab6gVh9sulDOLIcT91GWqfU1jTAgNSgtoIxJZ82H34hbTGPhdTe6jjm0mb
         3jA+klz7PyetHYldQx8yDLPXxvPCGHJL6DeqS8MAsgKm1qagU4mCs9QEmdRCcGvv/3UP
         RxWceVrhbXBexGdIOUzS/6vwD/xGtxEITWtxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fsU9VuWFOlT1sfk/R939adzdcpZZe9K2ZBodW4BQlqYpeZJR/FiUI/VvYsWH0IGYaI
         zM6kqsFMBqb6scbOjTugIOvoEUDUHqigZQ4/V4y2b2qQzIgkd/zJoQpY160qhKZ9np05
         L3IdduRLhJ8S72eQwzvvvhChOTRMZWYvVjDKQ=
Received: by 10.86.4.14 with SMTP id 14mr1790374fgd.8.1237887585891; Tue, 24 
	Mar 2009 02:39:45 -0700 (PDT)
In-Reply-To: <20090324090014.GA2075@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114442>

On Tue, Mar 24, 2009 at 11:00 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 24, 2009 at 10:57:43AM +0200, Felipe Contreras wrote:
>
>> > Really? They look very different. Here's a screenshot of the user-=
manual
>> > with patches 2 and 3 from your series applied, next to Wikipedia. =
Your
>> > text is smaller, and the line-spacing makes it look more scrunched=
:
>> >
>> > =C2=A0http://peff.net/wikipedia-git-textsize.png
>>
>> Hmm, strange, can you tell me what is the configured font/font-size =
you have?
>
> FreeSans, 14pt (and I default to sans-serif for proportional text).

You're right, for some reason in that font it's the difference is much
more noticeable. Both Google and Wikipedia seem to be doing some
tricks scaling up and down the font-size. Still, in the end the
font-size looks very small on Gmail... strange.

So in the end Wikipedia: 91%, Gmail: 80%, Google: 86%... small is 79%.

I've updated it again, changing the 'green' color to something more
subtle and reverted all the font-size changes.

--- a/Documentation/docbook-xsl.css
+++ b/Documentation/docbook-xsl.css
@@ -15,9 +15,8 @@ body blockquote {

 html body {
   margin: 1em 5% 1em 5%;
-  line-height: 1em;
+  line-height: 1.2;
   font-family: sans-serif;
-  font-size: small;
 }

 body div {
@@ -130,7 +129,7 @@ body pre {

 tt.literal, code.literal {
   color: navy;
-  font-size: 1em;
+  font-family: sans-serif;
 }

 code.literal:before { content: "'"; }
@@ -138,7 +137,7 @@ code.literal:after { content: "'"; }

 em {
   font-style: italic;
-  color: green;
+  color: #064;
 }

 div.literallayout p {

--=20
=46elipe Contreras
