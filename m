From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments pack protocol description in "RFC for the Git Packfile Protocol"  (long)
Date: Sat, 13 Jun 2009 11:30:55 +0200
Message-ID: <200906131130.57709.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 11:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFPa5-0000FT-Fn
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 11:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbZFMJbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZFMJbJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 05:31:09 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:44286 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZFMJbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 05:31:03 -0400
Received: by fxm12 with SMTP id 12so1054345fxm.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pBab341izlsyAtQsV5+SRyXlcylOF+g6wPNE83B2t1A=;
        b=brHm4Yosrt1FKh+0JpGkAPYFqSiJz9JJrx4PyzgEqRHuQpfgftBFrPsYjV2G1eyHuf
         0Jh6cvimBDy0D7s/t5YpHiEZD5MsbwRBLx3Na3RVH9AuHONMoYGajDG/C6y6MtqR6+BJ
         0dc0kui72Ltto0RD+0wFZu0h+lQn4oVd+pFI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iWyLg98rIP0a9UJFFPAJRzXdLdZ9J6Wwhr7iQgnKfY9flb3kDywJDPVZbn8nXdmZP8
         GVLN3MlAvY183fyRPisR+1gTklozTrdvFcbgbK0jssvFj8bPgO/kkzRn/0XjVnUWBz7z
         AlZg2V73XYPCsj7tknL6wtRlLg4oCZHlBmQQA=
Received: by 10.103.228.19 with SMTP id f19mr313838mur.124.1244885462701;
        Sat, 13 Jun 2009 02:31:02 -0700 (PDT)
Received: from ?192.168.1.13? (abwe201.neoplus.adsl.tpnet.pl [83.8.228.201])
        by mx.google.com with ESMTPS id 12sm932003muq.53.2009.06.13.02.31.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 02:31:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121489>

On Sat, 6 June 2009, Scott Chacon wrote:

> In addition to that, I started taking a shot at putting together an
> RFC formatted documentation of this protocol as was requested.  I may
> have _way_ missed the mark on what you were looking for originally,
> it's hard to say, not having read a lot of RFC documents - I probably
> ended up writing in a more bookish format rather than a technical
> spec, but whatever - maybe you'll find it helpful or can fix it up to
> more what you were expecting.  I'm not done with it - some of it is
> still basically unformatted comments from this previous thread, but at
> least it's laid out roughly how I thought it might be useful and I
> have fleshed out a lot of it.  You can find the RFC text output
> document here:
> 
> http://git-scm.com/gitserver.txt
> 
> And the xml doc I generated it from here:
> 
> http://github.com/schacon/gitserver-rfc

It would be nice to have RFC text output document alongside XML source
in gitserver-rfc document, e.g. following example of 'man' and 'html'
branches in git.git repository; which means having unrelated 'txt'
branch with text version of document for review.  Not everybody has
and wants to install tools required to turn XML into pretty RFC-like
text document... and it is hard to read XML.

As it is now, I find it much easier to read plain text formatted
output, and in current situation I cannot be sure that I am working on
(where working on means in this case commenting) the most recent
version of this RFC draft.  See also comment about embedding version
number in plain text version.

> 
> Perhaps if we're going to spend time getting this all correct, we
> should get a standalone technical doc all agreed upon, then I can
> relatively easily extract what's needed into that chapter of the
> Community book.
> 
> Thoughts?
> 
> Scott

Here are my thoughts and comments about the RFC.  Below the quoted
text is gitserver.txt from around 2009-06-10, not Scott Chacon email.


Well, I think having _detailed_ technical documentation of git pack
protocol would help tremendously implementers (whether it is
reimplementation of git, or just a git-server equivalent).  What exact
format it would be is not that important, I think...

------------------------------------------------------------------------
> Internet Engineering Task Force                                S. Chacon
> Internet-Draft                                                    GitHub
> Intended status: Informational                              June 6, 2009
> Expires: December 8, 2009

Why is expire date set?  Is it required? Why this date, by the way?
Is it some mandated/consensus expiry length, or is it date you plan
to revise this draft?

By the way, it would be nice if you tagged the source (e.g. v0.1), and
in during conversion from XML to RFC in text format embed version
number (GIT-VERSION-GEN) somewhere... perhaps in pseudo-filename.

>
>                          Git Server Protocol
>                         git-server-protocol-01

About naming: RFC drafts found at IETF have draft-<person>- prefix in
a draft "filename", e.g. 
  draft-mirashi-url-irc-01.txt, 
  draft-ietf-atompub-format-11.txt, 
  draft-templin-autoconf-dhcp-38.txt,
  draft-rfc-editor-rfc2223bis-08.txt,
(I am not sure if the .txt extension should be stated or not).

For example if the root commit of gitserver-rfc was tagged with v0.1,
then version which is 2 commits later could have pseudo filename look
like this: 'draft-schacon-git-server-protocol-01_2_ge036f1.txt', or
something like that (but the exact version might be put in other
place, and the filename might be then 'draft-*-01.txt').


Shouldn't it be "Git Pack Protocol" (or "Git Pack Protocol Exchange",
or "Git Packfile Protocol" as you described gitserver-rfc repository)
rather than "Git Server Protocol": the protocol is the same for
file:// URLs (over pipe), ssh:// URLs (over SSH), and git:// (over
socket using git-daemon)?  Although I guess the naming (the name is
the hardest thing... ;-) of this RFC draft could be left for later...


> Status of this Memo
>
>   By submitting this Internet-Draft, each author represents that any
>   applicable patent or other IPR claims of which he or she is aware
>   have been or will be disclosed, and any of which he or she becomes
>   aware will be disclosed, in accordance with Section 6 of BCP 79.
[...]

This boilerplate is fairly short, and I guess it could remain; but
wouldn't it be a good idea (if it is possible) to leave adding larger
parts of boilerplate text, which is required for RFC, but is not
necessary for draft?


> Abstract
>
>   This documents the Git version control system packfile based server
>   protocol.  It describes expected behaviour of client and server and
>   best current practices to help avoid pitfalls when implementing Git
>   daemon or SSH based servers in other language implementations.  It
>   will describe the data structures underlying Git repositories, how
>   that data is compressed into a packfile and how the contents of that
>   packfile are negotiated and transferred.  This does not cover the
>   HTTP based Git server protocols.

Good abstract.  "Packfile based server protocol" is a good name.  
I think however that the goal of git server/pack protocol exchange
should be stated explicitly: it is coming up with optimal packfile
to send.

I am not sure if description of Git repositories data structures (and
layout) wouldn't be better left for separate RFC (or refer to existing
documentation of those).  What we need for git server protocol (git
pack protocol) is actually a subset of this information, I think.

"This does not cover the HTTP based Git server protocols." is not
entirely correct.  What is not covered are "commit walker" based
protocols, like for example HTTP, but also FTP; also other "dumb"
protocols like (deprecated) rsync.  Those "commit walker" and other
"dumb" protocols do not require Git aware server (but they do require
extra helper info), so they are not strictly "Git _server_
protocols".  (That is a bit splitting hairs.)

[Table of contents]

> 1.  Introduction
>
>   The Git SCM is a snapshot based distributed version control system.
>   Each clone of each repository can synchronize with other nodes if
>   they have read or write access to them.  The two most common
>   protocols that these communications happen over are the custom 'Git'
>   protocol and over SSH.  In both of these cases, the communication
>   happens between the 'send-pack' process on the client side and
>   'receieve-pack' process on the server in the case of pushing changes
>   from the client to the server.  For fetching changes from the server
>   to the client, the 'fetch-pack' process on the client communicates
>   with an 'upload-pack' process on the server.  This document will
>   describe the ways in which these pairs of processes communicate.

What I find lacking is reference to RFC 2119 (which covers meaning of
MUST, etc.) and RFC 5234 (which covers ABNF).  It was present in XML
source, but was subsequently removed.

TAP (Test Anything Protocol) draft uses the following wording:
http://testanything.org/wiki/index.php/TAP_at_IETF:_Draft_Standard

  Conventions Used In This Document
  =================================

  The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
  "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
  document are to be interpreted as described in [RFC2119].

  The grammatical rules in this document are following ABNF and are to
  be interpreted as described in [STD68].

The wording for RFC 2119 reference is given in this RFC.  For
reference to ABNF standard one has to come up with ones own wording.
Another example would be:

  All the mechanisms specified in this document are described in both
  prose and an augmented Backus-Naur form (ABNF).  It is described in
  detail in [RFC5234].

RFC 2616 (Hypertext Transfer Protocol -- HTTP/1.1) has section titled
"1.2 Requirements" with reference to RFC 2119, and the following
paragraph:

  An implementation is not compliant if it fails to satisfy one or more
  of the MUST or REQUIRED level requirements for the protocols it
  implements. An implementation that satisfies all the MUST or REQUIRED
  level and all the SHOULD level requirements for its protocols is said
  to be "unconditionally compliant"; one that satisfies all the MUST
  level requirements but not all the SHOULD level requirements for its
  protocols is said to be "conditionally compliant."



TAP standard draft has there "Conventions Used In This Document"
subsection, with additional reference to ABNF, as stated above.  Other
RFCs (like RFC 3501, Internet Message Access Protocol - Version 4rev1) 
have it specified/referenced in the section where it is used for the
first time, e.g. (from RFC 3501):

  9. Formal Syntax
  ================

  The following syntax specification uses the Augmented Backus-Naur
  Form (ABNF) notation as specified in [ABNF].


What is also missing is section titled "Terminology" or "Definitions",
which can also be put in "Conventions Used in This Document" section,
where we would have to define _at least_ (I think) 'client', 'server',
'connection', 'request', probably 'channel' or 'sideband', 'capability'.

Also, if we are using "C: "/"S: " prefix convention, we should state
it explicitly, e.g. like it is written in RFC 3501 (IMAP):

  In examples, "C:" and "S:" indicate lines sent by the client and
  server respectively.

or like in draft RFC3920bis (XMPP core):

  In examples, lines have been wrapped for improved readability,
  "[...]" means elision, and the following prepended strings are used
  (these prepended strings are not to be sent over the wire):

  o  C: = a client
  o  S: = a server


After list of conventions there should be _overview_ of protocol,
before details; RFC 2616 (HTTP/1.1) has there "Overall Operation",
RFC 3501 (IMAP v4) has "Protocol Overview", and XMPP draft has
"Overview" section inside "Architecture" chapter.


> 2.  Git Data
>
>   Git has a relatively simple data format for storing it's objects.
>   There are four different types of objects that Git stores and these
>   make up nearly all the data that is transferred between a Git client
>   and server.  The four object types are the 'blob', the 'tree', the
>   'commit' and the 'tag'.  [...]

On one hand side I think that definitions of Git object model and Git
repository structure, file formats and layout should be either put in
_separate_ RFC, or (for the time being at least) simply refer to
existing documentation (it is only pack protocol which was lacking
much in matter of detailed description).

On the other hand side some of this information is actually required
to understand git server/pack protocol.  One needs to know about
reachability (of commits) to understand git pack protocol exchange,
and a way to come up with minimal set of commits; also one would have
to know how to interpret ASCII-art diagrams we use to visualize
history (commits parentage).  One needs to know about trees and blobs
(but not necessarily details about their exact format) and about Git
assumptions to understand how one should arrive at minimal set of
objects (in ordinary case, and in 'shallow' case).  One needs to
understand what tags are (but not necessarily details about their
format) to know e.g. what "include-tag" capability is about.  One
needs to understand what packfile is about to know what is thin pack,
and what "ofs-delta" capability is about.

[...]

> 2.1.  The SHA-1 ID
>
>   The Git database operates as a key-value store, where each object
>   that is put into the database is given an ID and then can be
>   retrieved from the database by that ID.  The ID is calculated as the
>   SHA-1 checksum of the content being stored plus a small header
>   appended to it of the format: [...]

The fact that Git repository is content-addressed object database,
using SHA-1 identifiers is fairly important; for pack protocol
description what matters is SHA-1 ids of commits and of tags, only.

BTW. it is prepended, and not appended.

[...]

> 2.2.5.  Git Object Model
>
>   The Git object model then are tags that point to commits, 

And that misunderstanding led to GitHub not supporting tags to blobs
(like e.g. junio-gpg-pub tag in git repository) :-).  Tag (both tag
reference, and tag object) can point to _any_ kind of object, be it
commit (most common), tag (chain of trust, retagging etc.), blob (like
e.g. public GPG keys) or trees (in Linux kernel first version didn't
have commit, so tree was tagged).

>   which point to zero or more commits and a single tree, which
>   points to one or more trees and/or blobs.

Sidenote: since submodules trees can point to commits; what is
important for pack-protocol considerations is that those commits do
not enter reachability considerations.

>
>                            +---+         +--+
>                            v   |         v  |
>             +-----+     +--------+     +--------+     +--------+
>             | Tag | --> | Commit | --> |  Tree  | --> |  Blob  |
>             +-----+     +--------+     +--------+     +--------+
>
>                           The Git Object Model
>
>   This creates a directed acyclic graph that can represent the project
>   state at any point.

Because tags can point at any kind of objects (though this is rare)
above diagram is not entirely true.  Also above diagram at least for
me seems to imply that there are loops in DAG of objects, while loops
are impossible (well, unless one screws up with grafts...) in Git.

But it would be hard to come up with ASCII-art diagram of DAG of
objects in Git repository; perhaps we can use ABNF to describe it (it
would be used to describe how objects refer to one another, not to
describe some syntax).

[...]

But I do not think that describing details of object format (loose,
packed, object) is necessarily here.  I'd rather leave it to existing
documentation (which describes Git model, and loose format, and pack
format with its indexes quite well), or separate RFC.


> 2.2.5.1.  The Commit Graph
>
>   Importantly for calculating data needs later on, the commit objects
>   by themselves are also a directed acyclic graph.  [...]

This is very important section, and I think necessary to understand
what git pack protocol is about.  We also introduce here ASCII-art
diagram convention for representing history in examples and
explanations. 


> 2.3.  Git References
>
>   The last major concept in the Git data structure is the reference.  A
>   reference is like a tag that moves.  When users work on a branch in
>   Git, the branch reference that is currently checked out is moved
>   forward to point to each new commit that is created.  So in Git, a
>   branch is really just a pointer to the latest commit on that branch -
>   the rest of the commits are obtained by walking the SHA-1 values one
>   commit at a time.
>
>                              +-- E  <= topic1
>                             /
>                        A -- B -- C -- G  <= master
>                          \
>                           +-- D -- F  <= topic2
>
>                       Commit Graph with References

I don't think that it is good description.  What's more such level of
detail is not necessary; what we have to know is that references are
local symbolic names for objects, usually for commits in DAG of
revisions.  Perhaps introduction of HEAD, refs/heads/* (which must
point to commits) and refs/tags/* would also be needed.

[...]

> 3.  Git Packfile Format
>
>   Once the client and the server figure out what objects need to be
>   transferred from one system to another, it will put all of those
>   objects into a "packfile".  This packfile is then streamed from one
>   system to the other.
>
>   The packfile itself is a very simple format.  There is a header, a
>   series of packed objects (each with it's own header and body) and
>   then a checksum trailer.  The first four bytes is the string 'PACK',
>   [...]

I am not sure if detailed description of packfile format is really
necessary.  We can always refer to Documentation/technical/pack-format.txt
and Documentation/technical/pack-heuristics.txt

By the way, if we are to describe details of packfile format, perhaps
we should use format described in section "5.2. Protocol Data
Definitions" of "RFC Style Guide"[1], based on RFC 791, isn't it?

[1]: http://www.rfc-editor.org/rfc-style-guide/rfc-style-manual-08.txt


> 3.1.  Deltified Objects
>
>   There are two object types that are new here - the delta object
>   types.  These are object data that are deltas of existing objects,
>   saving space in the storage.  The instance that creates the packfile
>   determines which objects it wants to deltify, if any, in order to
>   save space.  It is possible to send packfiles with no delta objects
>   in it, though it often saves quite a bit of space.
>
>   For the two delta object representations, the data portion contains
>   something that identifies which base object this delta representation
>   depends on, and then the delta to apply on the base object to
>   resurrect this object.
>
>   REF_DELTA uses 20-byte hash of the base object at the beginning of
>   data, while OFS_DELTA stores an offset within the same packfile to
>   identify the base object.  In either case, two important constraints
>   a reimplementor must adhere to are:
>   [...]

REF_DELTA vs OFS_DELTA is required to understand "ofs-delta"
capability; delta object and delta base is required to understand thin
packs.  But do we need more?

.......................................................................
The majority of comments touches the following chapter.  I haven't
examined previous chapters in more detail.

> 4.  Protocols
>
>   There are two transports over which the packfile protocol is
>   initiated.  The Git protocol is a simple, unauthenticated server that
>   simply takes the command (almost always 'upload-pack', though Git
>   servers can be configured to be globally writable, in which 'receive-
>   pack' initiation is also allowed) with which the client wishes to
>   communicate and executes it and connects it to the requesting
>   process.  The other transport is the SSH protocol, in which the
>   client basically just runs the 'upload-pack' or 'receive-pack'
>   process over the SSH protocol.

Sidenote: Actually there are three transports over which packfile
protocol is initiated.  There are: 
1.) transport over TCP socket, with git-daemon server being thin
    wrapper around whitelist of allowed commands, which uses
    git://git.example.com/repo.git URLs,
2.) transport over SSH, where clients run 'upload-pack' or
    'receive-pack' process over SSH protocol,
3.) transport over pipe, where client run 'upload-pack' or
    'receive-pack' process locally, file://git.example.com/repo.git 
    (pseudo)protocol URL.
We do not want to close possibility of other transports, like JGit's
amazon-s3:// protocol.

Sidenote: The set of commands which can be run via git protocol (via
TCP socket) from git-daemon is not limited to 'upload-pack';
'upload-archive' can be enables as well.


> 4.1.  Packet Line Format
>
>   Some data transmission in Git is done in what is called 'packet-line'
>   format.  

Should we mention that it is called pkt-line or pkt_line in sources
and in other documentation?

>           This is where each line of data sent is prepended with the
>   four byte hex encoded length of the rest of the payload being sent.
                                        ^^^^^^^
                                              \--- this is wrong!

The four hexadecimal characters length of packet line is length of the
whole line, including length prefix, and not only of payload.

>   This way the side receiving data can read 4 bytes and then know how
>   much more data is coming in that request.

Therefore it is "how much data", not "how much more data".

>
>   pkt-length = 4HEXDIGIT   ; length of pkt-payload
>   pkt-line   = pkt-length pkt-payload [ LF / CR ]

This is wrong.  I would use the following top-down definition:

    pkt-line   = pkt-length pkt-payload [ LF / CR / NUL ]
    pkt-length = 4HEXDIG     ; length of pkt-line

where

    NUL = %x00               ; \0

Perhaps even

    pkt-payload = *OCTET     ; data

OCTET, HEXDIG and LF are defined in "Core rules" (Appendix B) of ABNF
standard.  I think that _any_ terminator is allowed, but we should use
only LF (CR and NUL is used in some special cases); I am not convinced
if we should state that there is/can be terminator explicitly.

This definition does not cover special case (which should be
described) of

    pkt-flush = "0000"

>
>   In some cases Git will use a sideband packet-line format, where each
>   line is transmitted with the hex length prepended, followed by the
>   sideband channel (one byte) that the data is meant for, followed by
>   the actual data.
>
>   pkt-length   = 4HEXDIGIT   ; length of pkt-sb-payload
>   sideband-ch  = %d01-%d03
>   pkt-line-sb  = pkt-length sideband-ch pkt-payload [LF/CR]

This also contains some errors.

    pkt-line-sb  = pkt-length sideband-ch pkt-payload [LF/CR]
    pkt-length   = 4HEXDIGIT   ; length of pkt-line-sb
    sideband-ch  = %d01-%d03

I don't think that there is situation where we use NUL for terminator
for sideband packet-line format.  Also the CR terminator appear only
in sideband packer-line format for 2 channel, "progress message",
isn't it?

>
>   When a sideband is used, 2 means "progress messages, most likely
>   suitable for stderr". 1 means "pack data". 3 means "fatal error
>   message, and we're dead now".  No other channels are used or valid.
>
>   For the hex encoding, client and server SHOULD use lowercase, but
>   MUST accept mixed case (do case insensitive parsing of hex4).

Here, as you can see, we make use of RFC 2119, so we should reference
it somewhere at the beginning of RFC, as I have stated way above.

>
> 4.2.  Git Protocol
>
>   The Git protocol starts off by sending "git-receive-pack 'repo.git'"
>   on the wire using the pkt-line format, followed by a null byte and a
>   hostname parameter, terminated by a null byte.
>
>           0032git-upload-pack /project.git\0host=myserver.com\0

You didn't mention that above is only an example.  You didn't provide
with [example] invocation that results with such request.  Also it
would be better to use 'example.com' or 'git.example.com' as hostname,
see RFC 2606 ("Reserved Top-Level DNS Names" [TLD99]), to avoid
accidental conflicts.

We can use ABNF to encode it

    git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
    request-command   = 'git-upload-pack' / 'git-receive-pack' /
                        'git-upload-archive'   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = 'host' "=" hostname [ ":" port ]    

One should probably take a look at RFC for URLs/URIs for definitions
pertaining to host, pathname, URL, absolute and relative, etc.

Here I used for simplicity extension to ABNF that all characters
inside single quotes, like for example 'host' above are case
sensitive, as opposed to ABNF strings like "A" or "cmd" which are case
insensitive (in US-ASCII).

Otherwise one would have to specify 'host' as e.g. %x68.6f.73.74
or %d104.111.115.116, and similar for other cases.

>
>   Currently only 'host' is supported in the extra information.  It's
>   for the git-daemon name based virtual hosting.  See --interpolated-
>   path option to git daemon, with the %H/%CH format characters.

Actually from the discussion on git mailing list (which was after you
wrote the above) 'host' information is the only ALLOWED, not only the
only supported extra information (hence my definition).

>
>   Basically what the Git client is doing to connect to an 'upload-pack'
>   process on the server side over the Git protocol is this:
>
>     $ echo -e -n \
>       "0039git-upload-pack /schacon/gitbook.git\0host=github.com\0" |
>       nc -v github.com 9418

Nice to have example here, but in RFC you should, I think, not use
real-life URLs, as per "Instructions to RFC Authors" (The use of URLs
in RFCs is discouraged, because many URLs are not stable references.)

>
> 4.3.  SSH Protocol
>
>   Initiating the upload-pack or receive-pack processes over SSH is
>   simply executing the binary on the server via SSH remote execution.
>   It is basically equivalent to running this:
>
>            $ ssh git.example.com 'git-upload-pack /project.git'
>

This of course depends on the command used, whether it uses URL-like
request, or scp-like / ssh-like request (possibly with relative path).
But you write about this below.

>   For a server to support Git pushing and pulling for a given user over
>   SSH, that user needs to be able to execute one or both of those
>   commands via the SSH shell that they are provided on login.  On some
>   systems, that shell access is limited to only being able to run those
>   two commands, or even just one of them.
>
>   In an ssh:// format URI, it's absolute in the URI, so the '/' after
>   the host name (or port number) is sent as an argument, which is then
>   read by the remote git-upload-pack exactly as is, so it's effectively
>   an absolute path in the remote filesystem.
>
>                git clone ssh://user@example.com/project.git
>                                  |
>                                  v
>             ssh user@example.com 'git-upload-pack /project.git'
>
>   In a "user@host:path" format URI, its relative to the user's home
>   directory, because the Git client will run:
>
>                   git clone user@example.com:project.git
>                                    |
>                                    v
>             ssh user@example.com 'git-upload-pack project.git'
>
>
> 5.  Fetching Data From a Server
>
>   When one Git repository wants to get all the data that a second
>   repository has, the first can 'fetch' from the second.  This
>   operation determines what data the server has that the client does
>   not then streams that data down to the client in packfile format.

I know this is only a draft, but this paragraph could have been
written better...

>
>   The server side binary needs to be executable as 'git-upload-pack'
>   for fetching over SSH, since the Git clients will connect to the
>   server and attempt to run that.

Why do you single out SSH protocol here?

(Yes, I know it is a draft...)

>
>   The basic communication structure looks like this:
>
>    # Tell the client current branch heads and the last commit on each
>    S: SHA1 refname
>    S: ...
>    S: SHA1 refname
>    S: # flush -- it's your turn
>    # Tell the server what commits we want, and what we have
>    C: want name
>    C: ..
>    C: want name
>    C: have SHA1
>    C: have SHA1
>    C: ...
>    C: # flush -- occasionally ask "had enough?"
>    S: NAK          # nope, keep sending 'have's
>    C: have SHA1
>    C: ...
>    C: have SHA1
>    S: ACK
>    C: done
>    S: XXXXXXX -- packfile contents.

This perhaps is too detailed for the "Overview" section (to be
introduced)... or perhaps it is not.

Sidenote: we should standarize on SHA1 or SHA-1 thorough document.

>
> 5.1.  Initial Server Response
>
>   When the client initially connects, whether over the SSH or Git
>   transports, the server will immediately respond with a listing of
>   each reference it has (all branches and tags) along with the commit
>   SHA that each reference currently points to.
>
>   $ echo -e -n \
>     "0039git-upload-pack /schacon/gitbook.git\0host=github.com\0" |
>      nc -v github.com 9418

See the comment about using URLs in RFC.

>   Connection to github.com 9418 port [tcp/*] succeeded!

This is message from 'nc' (to be more exact from 'nc -v'), not from
git server.

>   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack \
>     thin-pack side-band side-band-64k ofs-delta shallow no-progress \
>     include-tag

Here we should point that we line-wrap lines for convenience, and that
we mark such situation with "\" as the last character (line
continuation)... which would be not necessary if we used "C: "/"S: "
prefix convention and the convention about line-wrapping here (see
note about "Conventions" chapter way above).

Also I think it would be better to specify LF terminator, e.g. 
as "\n" explicitly, as it is not present for "0000" pkt-flush line.

>   00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
>   003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
>   003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
>   003c525128480b96c89e6418b1e40909bf6c5b2d580f refs/tags/v1.0
>   003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
>   0000

Should we explain what "refs/tags/v1.0^{}" means, or should this be
left for later (or earlier, perhaps in separate subsection)?

>
>   Each line is terminated by a "\n" by convention only, which is
>   included in the 4 byte length declaration.  If a newline does not
>   terminate the line, the client should not complain.

I think it should read: server SHOULD terminate each non-flush line
using LF ("\n") terminator; client MUST NOT complain if there is no
terminator (is it?).

>
>   The exception is the flush line.  A length of "0000" means its a
>   flush packet, which has no data payload.  An "\n" after the "0000"
>   would break the protocol as the server would read that "\n" in a
>   context where it is expecting another pkt-line length declaration.
>   "\n" is not a hex digit, so "0000\n" is horribly horribly broken.

I know it is copy'n'paste from existing discussion (existing post),
but something like above shouldn't take place in RFC.

>
>   HEAD is not included if its detached - that is, if HEAD is not a
>   symbolic reference, a pointer to another branch, it is not included
>   in the initial server response.

Here we mix levels of abstraction a bit: a protocol, and a set (well,
a sequence) of references (reference info) returned.

By the way why detached HEAD is not present?  Server do not know
anything about what refspec client uses.  (That is not a comment to
Scott, but to the mailing list in general).
  
>                                    The client pattern matches the
>   advertisements against the fetch refspec, which is "refs/heads/
>   *:refs/remotes/origin/*" by default.  HEAD doesn't match the LHS, so
>   it doesn't get wanted by the client.

In this section we should describe both format of response, and also
(perhaps below "Capabilities" section) ordering and format of
reference info returned in server response.

Format of response could be presented in the following way:

    refs-response = refs-line [ NUL capabilities ] [ LF ]
                  *(refs-line [ LF ] )
                    pkt-flush
    refs-line     = pkt-length sha1-str SP refname
    sha1-str      = 40*HEXDIG
    capabilities  = capability *(SP capability)

Server and client SHOULD use lowercase for SHA1, both MUST treat SHA1
as case-insensitive.  (But I think you are writing about this later.)


>
> 5.2.  Capabilities

Sidenote: IMAP has a list of capabilities (usually defined in separate
"upgrade" RFC) maintained by IANA[3].  Perhaps Git also should have
such list of capabilities in the event some new capabilities will get
invented (e.g. symbolic references transfer, or multipack transport)?

[3]: http://www.iana.org/assignments/imap4-capabilities

>
>   On the very first line of the initial server response, the first
>   reference is followed by a null byte and then a list of space
>   delimited server capabilities.  These allow the server to declare
>   what it can and cannot do to the client.

"These allow the server to declare to the client what it can and
cannot do" perhaps?

>
>   Client sends space separated list of capabilities it wants.  It
>   SHOULD send a subset of server capabilities, i.e do not send
>   capabilities served does not advertise.  The client SHOULD NOT ask
>   for capabilities the server did not say it supports.
>
>   Server MUST ignore capabilities it does not understand.  Server MUST
>   NOT ignore capabilities that client requested and server advertised.

There was discussion about exact meaning of capabilities, and silently
ignoring unknown capabilities... but if I remember correctly you are
right here.

>
> 5.2.1.  multi-ack

multi_ack (historical reason).

>
>   The 'multi-ack' capability allows the server to return "ACK $SHA1
>   continue" as soon as it finds a commit that it can use as a common
>   base, between the client's wants and the client's have set.
[...]

Good explanation of this capability will require, I think, much
explanation and many ASCII-art diagrams.  Perhaps description of
capabilities should be moved to appendix?

> 5.2.2.  thin-pack
>
>   Server can send thin packs, i.e. packs which do not contain base
>   elements, if those base elements are available on clients side.
>   Client has thin-pack capability when it understand how to "thicken"
>   them adding required delta bases making them independent.

Client doesn't "have" capability.  Client "requests" capability.
But client MUST NOT (I think) request 'thin-pack' capability if it
cannot turn thin packs into proper independent packs.

>
>   Of course it doesn't make sense for client to use (request) this
>   capability for git-clone.

It turned out in further discussion to be not true.  Cloning with
'--reference' option can make use of thin packs.  Besides even client
can ask for 'thin-pack' option if it understand it even for initial
git-clone, as it is simply ignored when there are no common commits
(no bases and base objects to exclude from pack).

>
> 5.2.3.  side-band, side-band-64k
>
>   This means that server can send, and client understand multiplexed
>   (muxed) progress reports and error info interleaved with the packfile
>   itself.

[...]
>   The client MUST send only maximum of one of "side-band" and "side-
>   band-64k".  Server MUST favor side-band-64k if client requests both.

One should check further discussion about this...

[cut fragment for which I have no comments currently]

The question is: should we list all capabilities with detailed
description as usual in reference documentation like RFC (draft), or
should we move detailed description of current set of allowed
capabilities to the appendix?  (Note also that set of possible
capabilities is different for different commands; it is different for
git-upload-pack and for git-receive-pack.)

>
> 5.3.  Client Response
>
>   Once the client has the initial list of references that the server
>   has, as well as the list of capabilities, it will begin telling the
>   server what objects it wants and what objects it has, so the server
>   can make a packfile that only has the objects that the client needs.
>   The client will also send a list of the capabilities it supports out
>   of what the server said it could do.
>

In the example below you use "C: " prefix convention, and explicitly
mark end of line character ("\n" = LF) terminating 'packets'.  In the
final version we should, I think, standarize on one convention.

>   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
>     side-band-64k ofs-delta\n

Actually here client uses simply SPC (' ') to separate 'want' line
data from the list of requested capabilities, not NUL ("\0").

>   C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
>   C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
>   C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
>   C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
>   C: 0000
>   C: 0009done\n
>
>   S: 0008NAK\n
>   S: 0023\002Counting objects: 2797, done.\n
>   [...]
>   S: 2004\001PACK\000\000\000\002 [...]
>
>   It means the server is answering a prior flush from the client, and
>   is saying "I still can't serve you, keep tell me more have".

It is not clear that "it" here refers to NAK response from the server.


Here we have the following:

    client-cmd-set = want-cmd SP sha1-str [ SP capabilities ] [ LF ]
                   *(want-cmd SP sha1-str [ LF ] / pkt-flush )
                   *(have-cmd SP sha1-str [ LF ] / pkt-flush )
                     pkt-flush 
                     done-cmd
    want-cmd = 'want'
    have-cmd = 'have'
    done-cmd = 'done'

But it is a bit hard to express the exchange using only ABNF
formalism.  You would have to understand and describe when flush
packet can be send, when it should be send, and how to write
and read from socket as to not deadlock (block).

Also this is not _complete_ list of commands.  See upload-pack.c, and
builtin-fetch-pack.c where there is also "shallow", "unshallow" and
"deepen" commands listed (from shallow clone / fetch).  But perhaps we
should describe extra commands with the description of capabilities;
alternatively we can have here a subsection for each capability that
allows new client commands ("shallow", "unshallow" and "deepen" for
"shallow" capability) and new server responses ("ACK %s continue" for
"multi_ack" capability).

In the full description you would have to describe not only "NAK"
server response, but also "ACK %s" (and "ACK %s continue" for
"multi_ack" capability).

>
>   I have thought that after sending "0000" flush line client can wait
>   for NAK or ACK server response... but it is not the case.  When I
>   tried to read from server after "0000" flush and before "0009done\n",
>   my client (or netcat instance) deadlocked (hung) waiting for server
>   response.  I either did a mistake in my fake client, or I don't
>   understand git pack protocol correctly.  Should client wait for NAK
>   or ACK from server _only_ after sending maximum number of want/have
>   lines (256 if I remember correctly?)?  Yes. It means the client will
>   not issue any more "have" lines, as it has nothing further in its
>   history, so the server just has to give up and start generating a
>   pack based on what it knows.  After the client receives a "ACK" or
>   "NAK" for the number of outstanding flushes it still has, *after* it
>   has sent "done".  This also varies based on whether or not multi_ack
>   was enabled.  Its ugly.  But basically you keep a running counter of
>   each "flush" sent, and then you send a "done" out, and then you wait
>   until you have the right number of ACK/NAK answers back, and then the
>   stream changes format.

This certainly requires cleanup, as it is simple dump of fragments of
conversation on git mailing list.

>
>   > Should commands such as "have", "want", "done" use lower case or >
>   be case insensitive?  These MUST be lowercase. > Should status
>   indicators "ACK" and "NAK" be upper case, These MUST be uppercase.
>   Though "ACK %s continue" MUST be mixed case, as I just wrote it. >
>   Should capabilities be case sensitive, and should they be > compared
>   case sensitive or not?  No, they are case sensitive.

This also requires cleanup, even more so.

>
>   One thing that I did not see mentioned in this thread is that the
>   implementation is allowed to buffer non-flush packets and send
>   multiple of them out with a single write(2).  In other words,
>   packet_write() could buffer instead of directly calling safe_write(),
>   while packet_flush() must do safe_write() and make sure it drains. -
>   junio That's one reason why in JGit I call the flush packet of "0000"
>   end(), and flush() triggers the drain.  JGit buffers everything its
>   writing, but only by one standard "have" window IIRC.  JGit server
>   code triggers a flush() after side-band channel 2 packet ends, but
>   not an end(), because we only want to drain to the network, not
>   inject a bad "0000" packet in the stream.

These implementation details should probably go later, if they are to
be in this RFC at all...

>
>   0023\\002Counting objects: 2797, done.\n
>   002b\\002Compressing objects:   0% (1/1177)   \r
>   002c\\002Compressing objects:   1% (12/1177)   \r
>   002c\\002Compressing objects:   2% (24/1177)   \r
>   0053\\002Compressing objects:   7% (83/1177)   \r \
>           Compressing objects:   8% (95/1177)   \r
>   2004\\001PACK\\000\\000\\000\\002\\000\\000\n\\355\\225
>       \\017x\\234\\235\\216K\n\\302"...
>   2005\\001\\360\\204{\\225\\376\\330\\345]z\226\273"...
>   ...
>   0037\\002Total 2797 (delta 1799), reused 2360 (delta 1529)\n"

The server response should also be described (as far as it can) using
ABNF for syntax.  Server responds NAK or ACK if it has enough
information to generate full set of common commits, and responds with
packfile and sideband data (progress info and fatal errors) to the
'done' command from client.  There should be, I think, list of
possible error conditions, and also more details about coming up with
set of common objects, and stop condition9s).

Also one has to note that sideband data is sent only if "side-band" or
"side-band-64k" capability is requested by client (and server supports
it), and that length of pkt-line for older "side-band" is 1000
characters (max length is "03e8").  And that when client requests
"no-progress" no sideband 2 info is sent (but git server still use
channel 1 to send packfile).

>
>   Buffering.  There are two processes running on the server side, git-
>   pack-objects is producing these messages on its stderr, and the pack
>   data on stdout.  Both are actually a pipe read by git-upload-pack in
>   a select loop.  If pack-objects can write two messages into the pipe
>   buffer before upload-pack is woken to read them out, upload-pack
>   might find two (or more) messages ready to read without blocking.
>   These get bundled into a single packet, because, why not, its easier
>   to code it that way.  Its most common on the end like that, where we
>   dump 100%, and then immediately add the ", done" and start a new
>   progress meter.  Its less likely in the middle, where we try to space
>   out the progress updates to around 1 per second, or 1 per percentage
>   push - determines objects in DAG(C) not in DAG(S) and transfers them
>   via packfile

Those are implementation details; some of this info should be there in
RFC as security precautions (against deadlocking).  Such info would be
interesting, as e.g. JGit missed one of hidden in C git assumptions
and could deadlock due to lower buffer size (or something) in Java...

[removed part about pushing]

Note that for pushing 1.) set of possible server capabilities is
different, 2.) capabilities are presented in another way (with SP and
not NUL as separator).

-- 
Jakub Narebski
Poland
