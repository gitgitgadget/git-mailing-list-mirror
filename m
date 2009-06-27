From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Sat, 27 Jun 2009 14:14:52 +0200
Message-ID: <200906271414.53717.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <200906261133.47326.jnareb@gmail.com> <cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 14:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWoV-0001bu-Hp
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZF0MPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 08:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbZF0MPA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:15:00 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41866 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbZF0MPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:15:00 -0400
Received: by bwz9 with SMTP id 9so2460682bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=A9Az5JPHn01J+b0DdaH9ICX/96FLo8m19K1Sdppk7o4=;
        b=t3SKgnf8Kpl2HbDHUP0BATxoVmIOWcX7eDpxtDTds3W+PC4W4wRikR2iT9lD9KCTqS
         4CoIuwVvv50EBVBps0p/r1zcIG0moeaJq7BXDL0mwnDrgSnmpNwEoL39VhVNX96HjAZk
         YADGBT+bDqSB/ns76Y4I9tnzQvU4r1ZXNw6PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sYIAYEZKuP8szILAp3x+RohGaXfXqmJl38BF5tYAHWB5n+pN20TJlrBdKgrXrv3M2Y
         4I4mqjbeyJh3IEpfaMeyd3rFCxJiJwlZmvzDlyKUUlXvYzaHOJTpa1M5ueoeNyRUOP7i
         OxmVWj3IrCNJUKVOROKRXIUXJhRbpTYqqMblk=
Received: by 10.204.112.12 with SMTP id u12mr779395bkp.159.1246104901485;
        Sat, 27 Jun 2009 05:15:01 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 13sm7550247fks.52.2009.06.27.05.14.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:15:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122363>

On Fri, 26 June 2009, Giuseppe Bilotta wrote:
> 2009/6/26 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>>
>>> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
>>> index 68b22ff..7240ed7 100644
>>> --- a/gitweb/gitweb.css
>>> +++ b/gitweb/gitweb.css
>>> @@ -180,6 +180,10 @@ table {
>>
>>> +table.shortlog td:first-child{
>>> + =A0 =A0 text-align: right;
>>> +}

>> Second, I'd rather avoid more advanced CSS constructs; not all web
>> browsers support ':first-child' selector. =A0On the other hand addin=
g
>> class attribute to handle this would make page slightly larger.
>=20
> IIRC :first-child is supported from IE7 onwards. There are hacks to
> make it work on IE6, but I think they are definitely not worth it.

I was thinking here about more exotic web browsers, like Lynx, ELinks,
w3m (and w3m in Emacs), Konqueror (KHTML).  I think that both Opera
and Safari (and other browsers based on WebKit engine) support=20
':first-child' pseudo-class selector.  Also I'd rather not start trend
to use more advanced parts of CSS...

On the other hand if we introduce 'age coloring' (as used in projects
list view), by using classes age0..age2, then we would be able to use
class selector instead of :first-child pseudo-class selector for that.

>> Last, and most important: I don't agree with this change. =A0In my
>> opinion it does not improve layout (and you didn't provide support
>> for this change). =A0Right-align justification should be sparingly,
>> as it is not natural in left-to-right languages.
>=20
> Of course, in my opinion it does improve layout.
>=20
> The effect is to right-align the first column of shortlog view, i.e.
> the one holding the date. For dates that are presented as yyyy-mm-dd
> it makes not difference, but when the phrasing is 'X days ago' it
> provides the benefit of aligning the 'days ago' part instead of havin=
g
> it ragged. See it live at
>=20
> http://git.oblomov.eu/git/shortlog
>=20
> and judge for yourselves.

=46irst, it would be nice to have

  See it live at http://git.oblomov.eu/git/shortlog

in the patch comment (between "---\n" line and diffstat).

And I took a look how it looks like, with:
 $ <mark whole thread>
 $ <save as>
 $ git am -3 <file>
 $ stg uncommit -n <n>
 $ stg pop -a
 $ stg push
 $ gitweb-update.sh
 $ <view http://localhost/cgi-bin/gitweb/gitweb.cgi>
 $ ...


Second, even disregarding using ':first-child' pseudo-class selector
(it is not that important issue that it is required to have this
supported in all browsers), there is problem that this change is
_incomplete_.  Take a look at 'summary' view (probably most used
project specific action): in 'shortlog' you have date right-aligned,
while date column in 'heads' and 'tags' parts below you have date
left-aligned.

Third, in my opinion it does not improve layout.  You align on least
important part of relative date specification: on the word "ago".
Unit specifiers in relative date specification are of different length
so you don't have align (or rather have align in sort subsequences).

Compare:

  15 min ago
  6 hours ago
  10 hours ago
  2 days ago
  2 weeks ago
  6 months ago
  2009-06-12

with

    15 min ago
   6 hours ago
  10 hours ago
    2 days ago
   2 weeks ago
  6 months ago
    2009-06-12

What you probably want to have (and which I am not sure if it is worth
complication) is to align on first space/whitespace (align=3D"char" cha=
r=3D" ")

  15 min ago
   6 hours ago
  10 hours ago
   2 days ago
   2 weeks ago
   6 months ago
  2009-06-12

or even

  15 min    ago
   6 hours  ago
  10 hours  ago
   2 days   ago
   2 weeks  ago
   6 months ago
  2009-06-12

--=20
Jakub Narebski
Poland
