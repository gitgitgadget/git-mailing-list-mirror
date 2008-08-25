From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] mtn to git conversion script
Date: Mon, 25 Aug 2008 03:45:11 +0300
Message-ID: <94a0d4530808241745r3f2bdb56q9cfa8bc61f79223e@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	<20080824131405.GJ23800@genesis.frugalware.org>
	<94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
	<20080824224658.GA16590@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Mon Aug 25 02:46:21 2008
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXQDr-00009V-Hy
	for gcvmd-monotone-devel@m.gmane.org; Mon, 25 Aug 2008 02:46:19 +0200
Received: from localhost ([127.0.0.1]:51032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1KXQCt-0004Pv-Bb
	for gcvmd-monotone-devel@m.gmane.org; Sun, 24 Aug 2008 20:45:19 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1KXQCp-0004Pc-UL
	for monotone-devel@nongnu.org; Sun, 24 Aug 2008 20:45:15 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1KXQCn-0004OW-IK
	for monotone-devel@nongnu.org; Sun, 24 Aug 2008 20:45:14 -0400
Received: from [199.232.76.173] (port=59489 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1KXQCn-0004OK-CQ
	for monotone-devel@nongnu.org; Sun, 24 Aug 2008 20:45:13 -0400
Received: from rv-out-0708.google.com ([209.85.198.242]:28817)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <felipe.contreras@gmail.com>) id 1KXQCn-0001qI-5z
	for monotone-devel@nongnu.org; Sun, 24 Aug 2008 20:45:13 -0400
Received: by rv-out-0708.google.com with SMTP id f25so1105821rvb.22
	for <monotone-devel@nongnu.org>; Sun, 24 Aug 2008 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to
	:subject:cc:in-reply-to:mime-version:content-type
	:content-transfer-encoding:content-disposition:references;
	bh=6eOIxaSSon6haGUGnEsb7hDxkbW31PNwgyCHiyZfROA=;
	b=qrXWrg7BVTIrJ0pTZREXi5r/RCtt/Xe+sIdXbQA8Zf/xXAcu9dHmVfmZx8GW6L4e2a
	k9rFRh5x0rcDiMK3OMWozDfFIzXaUTmCKBqlX8f5iTAEOLVl6prYSMpL320Z8n40oIrC
	w0jl+eycZCEwdjr7j6XTxho2vfglU1+4mLCgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
	:content-type:content-transfer-encoding:content-disposition
	:references;
	b=p8ZHE22jENrRZ606DOXxSt+cEzRzXKdJ8NP/AXccEohqlD50hxRaBtsRmTKeqTReAE
	d2q8DR2fJ4v6l6rbYJw39lP+/jfbKYfZrQ+8HkjG2tiz8wVQ2FoxDRgQCQ5J9E+t30+N
	WwAAIiEmwQm4Mt47wXBeHK9sm6uKGSzDe5n+E=
Received: by 10.141.212.5 with SMTP id o5mr1841431rvq.20.1219625111387;
	Sun, 24 Aug 2008 17:45:11 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sun, 24 Aug 2008 17:45:11 -0700 (PDT)
In-Reply-To: <20080824224658.GA16590@spearce.org>
Content-Disposition: inline
X-detected-kernel: by monty-python.gnu.org: Linux 2.6 (newer, 2)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93580>

On Mon, Aug 25, 2008 at 1:46 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> On Sun, Aug 24, 2008 at 4:14 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> > On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> >> What do you think? Does it makes sense to have a 'write-raw' command?
>> >> Or should I somehow use 'fast-import'?
>> >
>> > Yes, you should. ;-)
>> >
>> > The syntax of it is not so hard, see for example 'git fast-export
>> > HEAD~2..' on a git repo and you'll see.
>> >
>> > This should help a lot if you are like me, who likes to learn from
>> > examples.
>>
>> Is it possible to create a fast-import from the index? I realize this
>> is not the best thing to do, but for now I would like to do that.
>
> No, fast-import uses its own internal structure and avoids the
> index file.

Yeah, I knew that, but wanted to just replace the 'write-raw' command.
To avoid doing unnecessary changes.

> Also, look at `git-hash-objects -w` as a replacement for your
> git-write-raw tool if you aren't going to use git-fast-import.

Awesome, but I just did it properly :)

A few comments regarding fast-import:

Why the distinction between 'from' and 'merge'? Doesn't it make more
sense to use 'parent' for both?

I'm doing: commit refs/mtn/d137c7046bae7e4a0144fee82bfce8061f61e3b3

So I was expecing this to work:
from mtn/d137c7046bae7e4a0144fee82bfce8061f61e3b3

But it didn't, probably because the commit hasn't actually been
committed. Wouldn't it make sense to store it as a temporal commit so
my script doesn't have to deal with that?

Anyway, very nice tool. It's going much faster (1h) compared to before (1 day).

Best regards.

-- 
Felipe Contreras
