From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 23:41:30 +0200
Message-ID: <200908212341.33324.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908211207.38555.jnareb@gmail.com> <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mebu9-0008RI-Hg
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbZHUVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbZHUVlp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:41:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:12669 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbZHUVlo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:41:44 -0400
Received: by fg-out-1718.google.com with SMTP id e21so257243fga.17
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Fzu0EwQhHdpq8pHJ/Aj5LrDRxtx0j8thVY58wcK5IAg=;
        b=IWAvZIpUnsS/QRMfvhTvatifI0sxgpfDgT9qglIVL8mMpWgaJQwLXlpjxQ9817gbLH
         1vOu457vWojk68/GQ1ibehQz9jM7zZt7jjTaKifbJKuCXKenufknul8ga15QUIczwvvN
         aqpmeE8hwN8ymzUmMusdEKwEY52xD6+WKpUXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=x7qoF9wZ7eLbUsb/sHJ718/Pc8JpdHSCzXfxo5Z0wPUJ5ITcMft2zCsnAJ8RJFjI8P
         4I0XO1kH6fMCG6arXCI7+FxyIZwqNa8T/heoCO/t+aCau9GDkf6hOrdyT5UqrKOVWnbc
         A7V3Hx+1rH0rSdOcqE9ANWMgg3fVGtzVjRYwQ=
Received: by 10.86.249.30 with SMTP id w30mr1217048fgh.35.1250890905120;
        Fri, 21 Aug 2009 14:41:45 -0700 (PDT)
Received: from ?192.168.1.13? (abwo198.neoplus.adsl.tpnet.pl [83.8.238.198])
        by mx.google.com with ESMTPS id 4sm6163770fge.16.2009.08.21.14.41.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 14:41:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126763>

On Fri, 21 Aug 2009, Nicolas Pitre wrote:
> On Fri, 21 Aug 2009, Jakub Narebski wrote:
>> On Thu, 20 Aug 2009, Nicolas Pitre wrote:
>>> On Thu, 20 Aug 2009, Jakub Narebski wrote:

>>>> It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
>>>> (well, that of course depends on repository).  Not that much that is
>>>> resumable.
>>> 
>>> Take the Linux kernel then.  It is more like 75 MB.
>> 
>> Ah... good example.
>> 
>> On the other hand Linux is fairly large project in terms of LoC, but
>> it had its history cut when moving to Git, so the ratio of git-archive
>> of HEAD to the size of packfile is overemphasized here.
> 
> That doesn't matter.  You still need that amount of data up front to do 
> anything.  And I doubt people with slow links will want the full history 
> anyway, regardless if it goes backward 4 years or 18 years back.

On the other hand unreliable link doesn't need to mean unreasonably
slow link.

Hopefully GitTorrent / git-mirror-sync would finally come out of 
vapourware and wouldn't share the fate of Duke Nukem Forever ;-),
and we would have this as an alternative to clone large repositories.
Well, supposedly there is some code, and last year GSoC project at
least shook the dust out of initial design and made it simplier, IIUC.
 
>> You make use here of a few facts:
[...]

>> 2. There is support in git pack format to do 'deepening' of shallow
>>    clone, which means that git can generate incrementals in top-down
>>    order, _similar to how objects are ordered in packfile_.
> 
> Well... the pack format was not meant for that "support".  The fact that 
> the typical object order used by pack-objects when serving fetch request 
> is amenable to incremental top-down updates is rather coincidental and 
> not really planned.

Ooops.  I meant "git pack PROTOCOL" here, not "git pack _format_".
the one about want/have/shallow/deepen exchange.
 
[...]
>>> A special 
>>> mode to pack-object could place commit objects only after all the 
>>> objects needed to create that revision.  So once you get a commit object 
>>> on the receiving end, you could assume that all objects reachable from 
>>> that commit are already received, or you had them locally already.
>> 
>> Yes, with such mode (which I think wouldn't reduce / interfere with
>> ability for upload-pack to pack more tightly by reordering objects
>> and choosing different deltas) it would be easy to do a salvage of
>> a partially completed / transferred packfile.  Even if there is no
>> extension to tell git server which objects we have ("have" is only
>> about commits), if there is at least one commit object in received
>> part of packfile, we can try to continue from later (from more);
>> there is less left to download.
> 
> Exact.  Suffice to set the last received commit(s) (after validation) as 
> one of the shallow points.

Assuming that received commit is full (has all prerequisites), and
is connected to the rest of body of partially [shallow] cloned 
repository.

>>>> Documentation/technical/shallow.txt doesn't cover "shallow", "unshallow"
>>>> and "deepen" commands from 'shallow' capability extension to git pack
>>>> protocol (http://git-scm.com/gitserver.txt).
>>> 
>>> 404 Not Found
>>> 
>>> Maybe that should be committed to git in Documentation/technical/  as 
>>> well?
>> 
>> This was plain text RFC for the Git Packfile Protocol, generated from
>> rfc2629 XML sources at http://github.com/schacon/gitserver-rfc
> 
> I suggest you track it down and prod/propose a version for merging in 
> the git repository.

Scott Chacon was (and is) CC-ed.
 
I don't know if you remember mentioned discussion about pack protocol, 
stemming from the fact that some of git (re)implementations (Dulwich,
JGit) failed to implement it properly, where properly = same as 
git-core, i.e. the original implementation in C... because there were
not enough documentation.


>>>> P.S. As you can see implementing resumable clone isn't easy...
>>> 
>>> I've been saying that all along for quite a while now.   ;-)
>> 
>> Well, on the other hand side we have example of how long it took to
>> come to current implementation of git submodules.  But if finally
>> got done.
> 
> In this case there is still no new line of code what so ever.  Thinking 
> it through is what takes time.

Measure twice, cut once :-)

In this case I think design upfront is a good solution.
 
>> The git-archive + deepening approach you proposed can be split into
>> smaller individual improvements.  You don't need to implement it all
>> at once.
[...]

>> 3. Create new git-archive pseudoformat, used to transfer single commit
>>    (with commit object and original branch name in some extended header,
>>    similar to how commit ID is stored in extended pax header or ZIP
>>    comment).  It would imply not using export-* gitattributes.
> 
> The format I was envisioning is really simple:
> 
> First the size of the raw commit object data content in decimal, 
> followed by a 0 byte, followed by the actual content of the commit 
> object, followed by a 0 byte.  (Note: this could be the exact same 
> content as the canonical commit object data with the "commit" prefix, 
> but as all the rest are all blob content this would be redundant.)
> 
> Then, for each file:
> 
>  - The file mode in octal notation just as in tree objects
>  - a space
>  - the size of the file in decimal
>  - a tab
>  - the full path of the file
>  - a 0 byte
>  - the file content as found in the corresponding blob
>  - a 0 byte
> 
> And finally some kind of marker to indicate the end of the stream.
> 
> Put the lot through zlib and you're done.

So you don't want to just tack commit object (as extended pax header,
or a comment - if it is at all possible) to the existing 'tar' and
'zip' archive formats.  Probably better to design format from scratch.
 
>> 4. Implement alternate ordering of objects in packfile, so commit object
>>    is put immediately after all its prerequisites.
> 
> That would require some changes in the object enumeration code which is 
> an area of the code I don't know well.

Oh.

-- 
Jakub Narebski
Poland
