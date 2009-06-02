From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 2 Jun 2009 23:39:07 +0200
Message-ID: <200906022339.08639.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbhc-0002kH-3J
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbZFBVjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2009 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbZFBVjN
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:39:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:57865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZFBVjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:39:12 -0400
Received: by fg-out-1718.google.com with SMTP id d23so966774fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a3/rzyqCClqltlSl/lvabAcCvfXlI6AMJGjfTiKwSBQ=;
        b=TQiEeeggpaw4YGIEazGIoyl4rNUuWVTZYh6brSZhdXa0MvckPJgXEmPEmJbqozWFDg
         yxsVqbnjrdu/QFLCJ2nBPFbw830iJO9R3E1s5udb2CiDRVfLEI2GUWZHhbWIHNgRARzJ
         2tnUWknG+RmUMHswwlVoenpA1l0Coo0uov3h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ldJbsvfzljFS190qx5tqUe9zbTnutvSADeNp9NUbsNnFsa+D2hwhHsJ4S4CXL6c8Tl
         HQvRb6OK48J+Jj//p06HI+TJ9diqJf+ZfOnl/A7SxVaHfZ9Zkcygk6pc3qVYFfodRwIT
         yWyWY+L+HOWHYuRQ6I0hc8l8furvFK+UsG5h4=
Received: by 10.86.65.18 with SMTP id n18mr341754fga.25.1243978752674;
        Tue, 02 Jun 2009 14:39:12 -0700 (PDT)
Received: from ?192.168.1.13? (abvt75.neoplus.adsl.tpnet.pl [83.8.217.75])
        by mx.google.com with ESMTPS id d6sm659906fga.22.2009.06.02.14.39.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 14:39:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120551>

On Thu, 14 May 2009, Scott Chacon wrote:
> On Tue, May 12, 2009 at 4:34 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:

>>> We have now proliferation of different (re)implementations of git:
>>> JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
>>> planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
>>> in Objective-C (for iPhone IIRC). =C2=A0At some time they would rea=
ch
>>> the point (or reached it already) of implementing git-daemon...
>>> but currently the documentation of git protocol is lacking.
[...]
=20
> It seems like if anyone would do what you're asking, it's probably me=
=2E
> [...]  I'm also working with Shawn
> on the Apress book, where I was going to try to document much of this
> information, perhaps I could try writing an RFC as an appendix or
> something - then that will force him to spend time correcting
> everything I got wrong :)  At least that might be a good starting
> point - I'm unfamiliar with the actual RFC process, so I'll research
> that a bit today.  I don't mind writing it, I think it would be reall=
y
> really useful to have, I just am unfamiliar with the process.

[...]
>>> It would be really nice, I think, to have RFC for git pack protocol=
=2E
>>> And it would help avoid incompatibilities between different clients
>>> and servers. =C2=A0If the document would contain expected behaviour=
 of
>>> client and server and Best Current Practices it would help avoid
>>> pitfals when implementing git-daemon in other implementation.
>>
>> Yea, it would be nice. =C2=A0But find me someone who knows the proto=
col
>> and who has the time to document the #!@* thing. =C2=A0Maybe I'll tr=
y
>> to work on this myself, but I'm strapped for time, especially over
>> the next two-to-three months.

I see that there is (at least beginnings of) description of git pack
protocol in section "Transfer Protocols"[1][2] of chapter "7. Internals
and Plumbing" of "Git Community Book".

 [1] http://book.git-scm.com/7_transfer_protocols.html
 [2] http://github.com/schacon/gitbook/blob/master/text/54_Transfer_Pro=
tocols/0_Transfer_Protocols.markdown

Let me quote here relevant part of this chapter, with some comment I am
not sure validity of... and therefore I'd like to ask for comments here=
,
rather than sending a patch of pull request already


> ### Fetching Data with Upload Pack ###
>
> For the smarter protocols, fetching objects is much more efficient.=20
> A socket is opened, either over ssh or over port 9418 (in the case of
> the git:// protocol), and the linkgit:git-fetch-pack[1] command on
> the client begins communicating with a forked
> linkgit:git-upload-pack[1] process on the server.

Is fetching over SSH exactly the same as fetching over git:// protocol?

>
> Then the server will tell the client which SHAs it has for each ref,
> and the client figures out what it needs and responds with a list of
> SHAs it wants and already has.
>
> At this point, the server will generate a packfile with all the
> objects that the client needs and begin streaming it down to the
> client.

We would want here probably the overview of client-server communication
as described in Documentation/technical/pack-protocol.txt

>
> Let's look at an example.
>
> The client connects and sends the request header. The clone command
>
> 	$ git clone git://myserver.com/project.git
>
> produces the following request:
>
> 	0032git-upload-pack /project.git\\000host=3Dmyserver.com\\000
>
> The first four bytes contain the hex length of the line (including 4
> byte line length and trailing newline if present). Following are the
> command and arguments. This is followed by a null byte and then the
> host information. The request is terminated by a null byte.

There is a question how to organize this information. Should we describ=
e
pkt-line format upfront, e.g. using ABNF notation from RFC 5234 used in
RFC documents:

  <pkt-line>   =3D ( <pkt-length> <pkt-payload> [ LF ] ) / <pkt-flush>
  <pkt-length> =3D 4HEXDIGIT                  ; length of <pkt-line>
  <pkt-flush>  =3D "0000"

or something like that?


Sidenote: wouldn't it be better to use \0 (\\0 in source) for NUL
character rather than \000 (\\000 in source) octal representation?

>
> The request is processed and turned into a call to git-upload-pack:
>
>  	$ git-upload-pack /path/to/repos/project.git

Is it "git-upload-pack" or "git upload-pack" nowadays?

Additionally currently this chapter does not explain how request for
"/project.git" is turned into /path/to/repos/project.git path to
repository both in case of git-daemon (git:// protocol) and SSH.

>
> This immediately returns information of the repo:

To be more exact this is information about references (I guess this
is information about heads only, is it?), with information about
server capabilities stuffed in.

>
> 	007c74730d410fcb6603ace96f1dc55ea6196122532d HEAD\\000multi_ack thin=
-pack side-band side-band-64k ofs-delta shallow no-progress
>       003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug
>       003d5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/dist
>       003e7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 refs/heads/local
>       003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master
>       0000=20
>
> Each line starts with a four byte line length declaration in hex. The
> section is terminated by a line length declaration of 0000.

Should we describe here, or in appendix, or in sidenote, or in footnote
all currently supported client capabilities and server capabilities?

 * multi_ack (why not mult-ack?)
 * thin-pack=20
 * side-band=20
 * side-band-64k=20
 * ofs-delta=20
 * shallow=20
 * no-progress

Is each line terminated by "\n" or "\0"? Is 'flush' line? This is not
clear from above description. From simple playing with nc (netcat) it
looks like each line with exception of '0000' is terminated with "\n".

>
> This is sent back to the client verbatim. The client responds with
> another request:
>
> 	0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack side-ban=
d-64k ofs-delta=20
> 	0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe
> 	0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a
> 	0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01
> 	0032want 74730d410fcb6603ace96f1dc55ea6196122532d

The semantics (meaning) of those 'want' lines is not described here,
although one can easily guess that those are commits that client does
not have, and which do want. In the case of "git clone" those are all
unique sha1 that client got (what happend if server has detached HEAD?)

It is not clear, but one can guess that set of capabilities that client
sends (without stuffing behind NUL character this time?) is a supported
by client and wanted subset of server capabilities.

> 	00000009done

=46irst I thought that this is an error... but not, the 'flush' ("0000"=
)
is not LF terminated.

>
> The is sent to the open git-upload-pack process which then streams
> out the final response:

Hmmm... here it is used different notation than above; everything is
within quotes, and end-of-line character is explicitly stated this time=
=2E

>
> 	"0008NAK\n"

What does this server response mean? That served doesn't need more
info? Having overview of client-server communication upfront would help
here (there would be a point to refer to).

> 	"0023\\002Counting objects: 2797, done.\n"
> 	"002b\\002Compressing objects:   0% (1/1177)   \r"
> 	"002c\\002Compressing objects:   1% (12/1177)   \r"
> 	"002c\\002Compressing objects:   2% (24/1177)   \r"
> 	"002c\\002Compressing objects:   3% (36/1177)   \r"
> 	"002c\\002Compressing objects:   4% (48/1177)   \r"
> 	"002c\\002Compressing objects:   5% (59/1177)   \r"
> 	"002c\\002Compressing objects:   6% (71/1177)   \r"
> 	"0053\\002Compressing objects:   7% (83/1177)   \rCompressing object=
s:   8% (95/1177)   \r" ...
> 	"005b\\002Compressing objects: 100% (1177/1177)   \rCompressing obje=
cts: 100% (1177/1177), done.\n"

I guess that it is sideband support: after pkt-length there is number
of stream (multiplexing), where 2 =3D \002 means stderr.

I wonder why sometimes it is one line per update, and sometimes there
is more than one update info stuffed in single line.

>       "2004\\001PACK\\000\\000\\000\\002\\000\\000\n\\355\\225\\017x\=
\234\\235\\216K\n\\302"...
>       "2005\\001\\360\\204{\\225\\376\\330\\345]z\226\273"...
> 	...
> 	"0037\\002Total 2797 (delta 1799), reused 2360 (delta 1529)\n"
> 	...

I can guess that this is example of multiplexing at work. Here again
some kind of ABNF notation would be IMHO useful, e.g.

  <pkt-line-sideband> =3D <pkt-length> <sideband-channel> <pkt-payload>=
 [ LF / CR ]
  <pkt-length-sideband> =3D 4HEXDIGIT   ; length of <pkt-line-sideband>
  <sideband-channel> =3D %d01-%d02

(Or something like that; I am not sure about ABNF details here).

> 	"<\\276\\255L\\273s\\005\\001w0006\\001[0000"

Hmmm... strange, this is not in pkt-line format...

>
> See the Packfile chapter previously for the actual format of the
> packfile data in the response.

--=20
Jakub Narebski
Poland
