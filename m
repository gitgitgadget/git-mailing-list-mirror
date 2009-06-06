From: Scott Chacon <schacon@gmail.com>
Subject: Re: Comments pack protocol description in "Git Community Book" 
	(second round)
Date: Sat, 6 Jun 2009 14:58:00 -0700
Message-ID: <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
References: <200905122329.15379.jnareb@gmail.com>
	 <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
	 <200906022339.08639.jnareb@gmail.com>
	 <200906062338.02451.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD3u2-0007in-AG
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 23:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZFFV6C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 17:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbZFFV6A
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 17:58:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:23582 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZFFV56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 17:57:58 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1457675ywb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i3gPQ8FPVYiOoWvOINO6VwOX7ULv0F3RClKPwyUud7E=;
        b=dD9ZELrJVORQT2DKAFFv/PhaThF345K5B58UY4Uab3Baie8qouCPb6VIooOXTJGCG7
         TfrCiJUVblu9yknc5Tyoiw6tt0JMxGsVEHiFsTOVdlqW7NNGPGd73bS0zw8TTrDxSRfW
         hkaIbMVRV/ple3ez2dnEeFlVIDgFlbtiBmFbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dAjOVu55Fx2hZk2Snnsr1nexgMc/aOMBnZlbkr5DS4dY8HB8Ku3Mgo3YbDqq9Xn5Wa
         Ikz0q/vPUaW0+e6RABBo+x85JtFOXrQU7JniaWd3ioxJPEGAlPEFejZAoM+YOnkhxOT0
         h6yK8RouirWaWeyjM8L244V7XesiaySU/oYFw=
Received: by 10.100.144.14 with SMTP id r14mr5040172and.120.1244325480352; 
	Sat, 06 Jun 2009 14:58:00 -0700 (PDT)
In-Reply-To: <200906062338.02451.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120941>

Hey,

On Sat, Jun 6, 2009 at 2:38 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> There are beginnings of description of git pack protocol in section
> "Transfer Protocols"[1][2] of chapter "7. Internals and Plumbing"
> of "Git Community Book" (http://book.git-scm.com).
>
> =C2=A0[1] http://book.git-scm.com/7_transfer_protocols.html
> =C2=A0[2] http://github.com/schacon/gitbook/blob/master/text/54_Trans=
fer_Protocols/0_Transfer_Protocols.markdown
>
> This is second round of my comments about this item. I'd like to have
> some more comments about git pack protocol before trying to come up
> with formulation which is good enough to send as patch against source
> of mentioned section.
>

I can certainly fix up this chapter with these comments - I understand
the protocol a bit better now than I did when I originally wrote this.

In addition to that, I started taking a shot at putting together an
RFC formatted documentation of this protocol as was requested.  I may
have _way_ missed the mark on what you were looking for originally,
it's hard to say, not having read a lot of RFC documents - I probably
ended up writing in a more bookish format rather than a technical
spec, but whatever - maybe you'll find it helpful or can fix it up to
more what you were expecting.  I'm not done with it - some of it is
still basically unformatted comments from this previous thread, but at
least it's laid out roughly how I thought it might be useful and I
have fleshed out a lot of it.  You can find the RFC text output
document here:

http://git-scm.com/gitserver.txt

And the xml doc I generated it from here:

http://github.com/schacon/gitserver-rfc

Perhaps if we're going to spend time getting this all correct, we
should get a standalone technical doc all agreed upon, then I can
relatively easily extract what's needed into that chapter of the
Community book.

Thoughts?

Scott

> The relevant parts of above source are quoted as if they were email
> I am replying too.
>
> I have CC-ed everybody who participated in this subthread (originally
> named "Re: Request for detailed documentation of git pack protocol").
>
> ....
>> ### Fetching Data with Upload Pack ###
>>
>> For the smarter protocols, fetching objects is much more efficient. =
=C2=A0A
>> socket is opened, either over ssh or over port 9418 (in the case of
>> the git:// protocol), and the git-fetch-pack(1) command on the clien=
t
>> begins communicating with a forked git-upload-pack(1) process on the
>> server.
>>
>> Then the server will tell the client which SHAs it has for each ref,
>> and the client figures out what it needs and responds with a list of
>> SHAs it wants and already has.
>
> It would be probably more clear here to state explicitely that there
> are two lists, i.e. "a list of SHAs it wants and a list of SHAs it
> already has".
>
>>
>> At this point, the server will generate a packfile with all the
>> objects that the client needs and begin streaming it down to the
>> client.
>
> This is a bit of oversimplification. =C2=A0In most simple case like c=
lient
> using git-clone to get all objects it is true that server can generat=
e
> packfile and stream it to client after client tells a list of wanted
> SHAs. =C2=A0In more complicated case however there can be series of
> exchanges between client and server, with client sending sets of
> commits it have, and server responding whether it is enough (or
> perhaps this line of commits is uninteresting)... and only then
> arriving at list of objects to send in a packfile.
>
>>
>> Let's look at an example.
>
> I think that before example we should have short description (sketch)
> of the whole exchange; for example the one taken from
> 'Documentation/technical/pack-protocol.txt':
>
> upload-pack (S) | fetch/clone-pack (C) protocol:
>
> =C2=A0# Tell the puller what commits we have and what their names are
> =C2=A0S: SHA1 name
> =C2=A0S: ...
> =C2=A0S: SHA1 name
> =C2=A0S: # flush -- it's your turn
> =C2=A0# Tell the pusher what commits we want, and what we have
> =C2=A0C: want name
> =C2=A0C: ..
> =C2=A0C: want name
> =C2=A0C: have SHA1
> =C2=A0C: have SHA1
> =C2=A0C: ...
> =C2=A0C: # flush -- occasionally ask "had enough?"
> =C2=A0S: NAK
> =C2=A0C: have SHA1
> =C2=A0C: ...
> =C2=A0C: have SHA1
> =C2=A0S: ACK
> =C2=A0C: done
> =C2=A0S: XXXXXXX -- packfile contents.
>
>
>>
>> The client connects and sends the request header. The clone command
>>
>> =C2=A0 =C2=A0 =C2=A0 $ git clone git://myserver.com/project.git
>>
>> produces the following request:
>>
>> =C2=A0 =C2=A0 =C2=A0 0032git-upload-pack /project.git\\000host=3Dmys=
erver.com\\000
>
> Although fetching via SSH protocol is, I guess, much more rare than
> fetching via anonymous unauthenticated git:// protocol, it _might_ be
> good idea to tell there that fetching via SSH differs from above
> sequence that instead of opening TCP connection to port 9418 and
> sending above packet, and later reading from and writing to socket,
> "git clone ssh://myserver.com/srv/git/project.git" calls
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ssh myserver.com git-upload-pack /srv/git/=
project.git
>
> and later reads from standard output of the above command, and writes
> to standard input of above command.
>
> The rest of exchange is _identical_ for git:// and for ssh:// (and
> I guess also for file:// pseudoprotocol).
>
>>
>> The first four bytes contain the hex length of the line (including 4
>> byte line length and trailing newline if present). Following are the
>> command and arguments. This is followed by a null byte and then the
>> host information. The request is terminated by a null byte.
>
> I think it would be better to describe packet (chunk) format, called
> pkt-line in git, separately from describing the contents of above
> packet; either first pkt-line then command, or first command then
> pkt-line. =C2=A0Otherwise we would be left with describing pkt-line f=
ormat
> many times, as it is done in current version of this chapter.
>
>
> In git clients communicates with server using a packetized stream,
> where each line (packet, chunk) is preceded by its length (including
> the header) as a 4-byte hex number. =C2=A0A length of 'zero', i.e. pa=
cket
> "0000" has a special meaning: it means end of stream / flush
> connection. =C2=A0The "# flush ..." in description of client--server
> exchange above is done using exactly "0000" packet.
>
> Footnote: this format somewhat reminds / resembles 'chunked' transfer
> encoding used in HTTP[1], although there are differences.
> =C2=A0http://en.wikipedia.org/wiki/Chunked_transfer_encoding
>
>>
>> The request is processed and turned into a call to git-upload-pack:
>>
>> =C2=A0 =C2=A0 =C2=A0 $ git-upload-pack /path/to/repos/project.git
>
> This is alternate place where we could tell about fetching via ssh://
>
> We probably should tell where /path/to/repos that /project.git is
> prefixed with comes from; it is from --base-path=3D/path/to/repos
> argument to git-daemon (a sort of "GIT root").
>
> BTW. (this is just a very minor nit) shouldn't we use FHS compliant
> path, i.e. "/srv/git" instead of "/path/to/repos" (and follow RFC in
> using "example.com" in place of "myserver.com")?
>
>>
>> This immediately returns information of the repo:
>>
>> =C2=A0 =C2=A0 =C2=A0 007c74730d410fcb6603ace96f1dc55ea6196122532d HE=
AD\\000multi_ack thin-pack side-band side-band-64k ofs-delta shallow no=
-progress include-tag\\n
>> =C2=A0 =C2=A0 =C2=A0 003e7d1665144a3a975c05f1f43902ddaf084e784dbe re=
fs/heads/debug\\n
>> =C2=A0 =C2=A0 =C2=A0 003d5a3f6be755bbb7deae50065988cbfa1ffa9ab68a re=
fs/heads/dist\\n
>> =C2=A0 =C2=A0 =C2=A0 003e7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 re=
fs/heads/local\\n
>> =C2=A0 =C2=A0 =C2=A0 003f74730d410fcb6603ace96f1dc55ea6196122532d re=
fs/heads/master\\n
>> =C2=A0 =C2=A0 =C2=A0 0000
>
> I have added explicit LF terminators in the form of "\\n" (which woul=
d
> render as "\n"), mainly because "0000" flush packed _doesn't_ have it=
=2E
> Also I have added "include-tag", as modern git installations provide
> this capability.
>
> Here is a dilemma: currently example output is provided almost exactl=
y
> as-is, only indented and with some quoting/escaping (\\000 or \\0 for
> NUL character, \\n for LF, later \\001 and \\002 for 0x01 and 0x02
> bytes). =C2=A0To know if given example output is what client sends or=
 what
> server outputs, you have to read the narrative. =C2=A0Alternate solut=
ion
> would be to use "C: " and "S: " prefixing (perhaps with some extra
> format to make it more clear that it is not part of data), used in
> pack-protocol.txt technical documentation, and proposed for describin=
g
> network protocols by some RFC (I don't remember which, unfortunately)=
=2E
> Which one to choose?
>
>
> We would want, at some point, describe that first line of first
> response from server contains 'stuffed' behind "\0" (NUL) space
> separated list of capabilities our server supports. =C2=A0Those
> capabilities would have to be described somewhere: as a sidebar,
> or in a separate subsection, or in an appendix.
>
> Below there is (for completeness) list of git-upload-pack
> capabilities, with short description of each:
>
> =C2=A0* multi_ack (for historical reasons not multi-ack)
>
> =C2=A0 It allows the server to return "ACK $SHA1 continue" as soon as=
 it
> =C2=A0 finds a commit that it can use as a common base, between the
> =C2=A0 client's wants and the client's have set.
>
> =C2=A0 By sending this early, the server can potentially head off the
> =C2=A0 client from walking any further down that particular branch of=
 the
> =C2=A0 client's repository history.
>
> =C2=A0 See the thread for more details (posts by Shawn O. Pearce and =
by
> =C2=A0 Junio C Hamano).
>
> =C2=A0* thin-pack
>
> =C2=A0 Server can send thin packs, i.e. packs which do not contain ba=
se
> =C2=A0 elements for some delta chains, if those base elements are
> =C2=A0 available on client side. =C2=A0Client has thin-pack capabilit=
y when it
> =C2=A0 understand how to "thicken" them adding required delta bases,
> =C2=A0 making those packfiles independent.
>
> =C2=A0 Of course it doesn't make sense for client to use (request) th=
is
> =C2=A0 capability for git-clone... But if the client does request it =
(and
> =C2=A0 I think modern clients actually do request it, even on initial
> =C2=A0 clone case) the server won't produce a thin pack. Why? =C2=A0T=
here is no
> =C2=A0 common base, so there is no uninteresting set to omit from the
> =C2=A0 pack. =C2=A0:-)
>
> =C2=A0* side-band
> =C2=A0* side-band-64k
>
> =C2=A0 This means that server can send, and client understand multipl=
exed
> =C2=A0 (muxed) progress reports and error info interleaved with the
> =C2=A0 packfile itself.
>
> =C2=A0 These two options are mutually exclusive. A client should ask =
for
> =C2=A0 only one of them, and a modern client always favors side-band-=
64k.
> =C2=A0 If client ask for both, server uses side-band-64k.
>
> =C2=A0 Older side-band allows only up to 1000 bytes per packet.
>
> =C2=A0* ofs-delta
>
> =C2=A0 Server can send, and client understand PACKv2 with delta refer=
ing
> =C2=A0 to its base by position in pack rather than by SHA-1. =C2=A0Bo=
th can
> =C2=A0 send/read OBJ_OFS_DELTA, aka type 6 in a pack file.
>
> =C2=A0* shallow
>
> =C2=A0 Server can send shallow clone (git clone --depth ...).
>
> =C2=A0* no-progress
>
> =C2=A0 Client should use it if it was started with "git clone -q" or
> =C2=A0 something, and doesn't want that side brand 2. =C2=A0We still =
want
> =C2=A0 sideband 1 with actual data (packfile), and sideband 3 with er=
ror
> =C2=A0 messages.
>
> =C2=A0* include-tag
>
> =C2=A0 If we pack an object to the client, and a tag points exactly a=
t
> =C2=A0 that object, we pack the tag too. =C2=A0In general this allows=
 a client
> =C2=A0 to get all new tags when it fetches a branch, in a single netw=
ork
> =C2=A0 connection, instead of two (separate connection for tags).
>
> =C2=A0 This capability is not to be used when client was called with
> =C2=A0 '--no-tags'.
>
>>
>> Each line starts with a four byte line length declaration in hex. Th=
e
>> section is terminated by a line length declaration of 0000.
>
> This repetition would not be necessary if pkt-line format had its own
> description somewhere before. =C2=A0We would probably still want to r=
emind
> the reader that "0000" line length declaration means 'flush'.
>
>>
>> This is sent back to the client verbatim.
>
> Hmmm... "sent back ... verbatim"? I wonder what did you want to say
> here...
>
>> The client responds with another request:
>>
>> =C2=A0 =C2=A0 =C2=A0 0054want 74730d410fcb6603ace96f1dc55ea619612253=
2d multi_ack side-band-64k ofs-delta\\n
>> =C2=A0 =C2=A0 =C2=A0 0032want 7d1665144a3a975c05f1f43902ddaf084e784d=
be\\n
>> =C2=A0 =C2=A0 =C2=A0 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab6=
8a\\n
>> =C2=A0 =C2=A0 =C2=A0 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c=
01\\n
>> =C2=A0 =C2=A0 =C2=A0 0032want 74730d410fcb6603ace96f1dc55ea619612253=
2d\\n
>> =C2=A0 =C2=A0 =C2=A0 0000
>> =C2=A0 =C2=A0 =C2=A0 0009done\\n
>
> Here again I added explicit LF terminator, and split off "0000" flush
> packet in separate line, to make this request (well, two requests)
> more clear.
>
> The first line of this request contains capabilities client wants to
> use. =C2=A0It should be some subset of capabilities server supports.
>
>>
>> The is sent to the open git-upload-pack process which then streams o=
ut
>> the final response:
>
> "_The_ is send"?
>
> I would remove quotes around lines of server response below, but woul=
d
> leave explicit \n for LF, and \\001 and \\002 for bytes 0x01 and 0x02
> denoting channel.
>
>>
>> =C2=A0 =C2=A0 =C2=A0 "0008NAK\n"
>
> This NAK means that server did not found [closed] set of common
> ancestors. It is response to "0000" flush line ("had enough?" line)
> from client. As the example is about git-clone, and client doesn't
> _have_ any commits to show server as candidates for common ancestors
> (calculation), it replies with "done" to get pack.
>
>> =C2=A0 =C2=A0 =C2=A0 "0023\\002Counting objects: 2797, done.\n"
>
> This is a bit untypical example, as for larger repositories like Linu=
x
> kernel or even git repository, usually you would have much more
> objects, and actually object enumeration would take more time. =C2=A0=
You
> would see many
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"0020\\002Counting objects: 10662 =C2=A0 \=
r"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"0020\\002Counting objects: 22318 =C2=A0 \=
r"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"0020\\002Counting objects: 29506 =C2=A0 \=
r"
>
> packets before
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"0023\\002Counting objects: 65058, done.\n=
"
>
>> =C2=A0 =C2=A0 =C2=A0 "002b\\002Compressing objects: =C2=A0 0% (1/117=
7) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 1% (12/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 2% (24/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 3% (36/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 4% (48/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 5% (59/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "002c\\002Compressing objects: =C2=A0 6% (71/11=
77) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 "0053\\002Compressing objects: =C2=A0 7% (83/11=
77) =C2=A0 \rCompressing objects: =C2=A0 8% (95/1177) =C2=A0 \r"
>> =C2=A0 =C2=A0 =C2=A0 ...
>> =C2=A0 =C2=A0 =C2=A0 "005b\\002Compressing objects: 100% (1177/1177)=
 =C2=A0 \rCompressing objects: 100% (1177/1177), done.\n"
>
> Sidenote: the reason why there is sometimes more than one line send i=
n
> a single packet / single pkt-line is buffering between git-pack-objec=
ts
> which produces those messages to pipe, and git-upload-pack which read=
s
> them and sends them to client. =C2=A0If pack-objects can write two me=
ssages
> into the pipe buffer before upload-pack is woken to read them out,
> upload-pack might find two (or more) messages ready to read without
> blocking. =C2=A0These get bundled into a single packet, because, why =
not,
> its easier to code it that way.
>
> Here or a little later we probably should explain (even though it is
> fairly obvious), that final response from server is (here) in pkt-lin=
e
> with sideband format, where first byte of data denotes channel
> (stream) number: 1 for data, 2 for progress info, 3 for fatal errors.
>
>> =C2=A0 =C2=A0 =C2=A0 "2004\\001PACK\\000\\000\\000\\002\\000\\000\n\=
\355\\225\\017x\\234\\235\\216K\n\\302"...
>> =C2=A0 =C2=A0 =C2=A0 "2005\\001\\360\\204{\\225\\376\\330\\345]z\226=
\273"...
>
> Here I think it would be enough to show only the fragment which is
> packfile signature...
>
>> =C2=A0 =C2=A0 =C2=A0 ...
>> =C2=A0 =C2=A0 =C2=A0 "0037\\002Total 2797 (delta 1799), reused 2360 =
(delta 1529)\n"
>> =C2=A0 =C2=A0 =C2=A0 ...
>> =C2=A0 =C2=A0 =C2=A0 "<\\276\\255L\\273s\\005\\001w0006\\001[0000"
>
> This line is I think is broken in wrong place. =C2=A0It is the tail
> end of some packet (each packed begins with 4 characters wide 0-padde=
d
> length of chunk as hex number; "<\\276\\255L" does not match 4HEXDIG)=
,
> followed by "0000" 'flush' packet (here it signals end of stream).
>
>>
>> See the Packfile chapter previously for the actual format of the
>> packfile data in the response.
>>
>>
> ....
> --
> Jakub Narebski
> Poland
>
