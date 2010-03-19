From: bruno le hyaric <bruno.lehyaric@gmail.com>
Subject: Re: How to start well for a special git construction
Date: Fri, 19 Mar 2010 21:30:20 +0100
Message-ID: <e8be804e1003191330w70d9827cr1cfc1f46a5f45a2a@mail.gmail.com>
References: <e8be804e1003181226y20328151s75641f4341ca12d8@mail.gmail.com>
	 <32541b131003181348j1e7d5dfamec09bed2c81916d8@mail.gmail.com>
	 <e8be804e1003191231h68983d75od0ef7ec5b715e19f@mail.gmail.com>
	 <32541b131003191259j1208118ayca6c79c21cae2291@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 21:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsipw-00029Z-H1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab0CSUaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 16:30:23 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50768 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0CSUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 16:30:22 -0400
Received: by bwz1 with SMTP id 1so383280bwz.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=yAFHBOnVEvCHtMOhtWye1BwL6weC/V/qw99iKdGx7UM=;
        b=DQ9N/M9oCpVEk08LyQw+AIvkxioN9pLu39ZL2ijtN4iVa5uvAwl38KmDDXoSxqrDMG
         uuJr8kQfq9VOF27vOwOFFh/wOeYJI0rnBjdeZLuYIDirW5d47HByADKhXi/OA5f4OMF4
         dwmW7eqUQfidKZyGFO4rHY4jPovz08io86Yxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=hdHvoYduzLGpJ2k138uSFiN9sIhqescbLkTmrLLez3YjbOfxQuohlJbVhhMEnjlTD1
         sikKYvGEO1Xtgy0dBQ1CyDtHBVPSW4IBkiUYEB8EV2N6wlQKyF5HKeL+/YPks6iwA91b
         aYX3thlTmxFpYbRmF3+ldP59n0HSEkLSwHzJU=
Received: by 10.204.128.144 with SMTP id k16mr578212bks.182.1269030620349; 
	Fri, 19 Mar 2010 13:30:20 -0700 (PDT)
In-Reply-To: <32541b131003191259j1208118ayca6c79c21cae2291@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142643>

Thanks for your help.
I've just created my empty new branch for delivery stuff... and
effectively the branch is empty :-D
Any idea on how I can add executable files in this empty branch from
the master branch? Is that possible?
(perhaps I'm using Git in a bad way)

If I want to manage those file with Git, it's just for the purpose to
merge them in another repository. I would have choose to have only one
repository for all things... but basically, the two frameworks are not
maid to be used together. So I thought that using two distinct
repositories was better. Especially for Restfulx code generation which
need a lot of unsalubrious hacks. I don't want to keep them in my
final application...

in any case, thank you very much for your quick answers.


Bruno

2010/3/19, Avery Pennarun <apenwarr@gmail.com>:
> On Fri, Mar 19, 2010 at 3:31 PM, bruno le hyaric
> <bruno.lehyaric@gmail.com> wrote:
>> 2010/3/18, Avery Pennarun <apenwarr@gmail.com>:
>>> Do you actually have multiple projects that you're working on, or are
>>> you the maintainer of an application that uses other people's
>>> projects?
>>
>> I'm starting building a new web application based on 2 existing
>> frameworks (Spree, RestfulX).
>
> This basic explanation leads me to believe you only really want one
> repo (at least once you have it set up): the one for your app.  Other
> people already host repos for the other projects.
>
>> I want to use latest upstream of both frameworks. For the moment I
>> don't have reason to make patches for these, but if I can do that,
>> this is better. In the other case I can imagine developping patch in
>> distinct repository in a independant way...
>
> You can embed the contents of the other repositories into yours in one
> of three ways that I know of:
>
> - Just copy the files from those libraries into your project's repo.
> This is cheap and easy, although it makes it a bit harder to push
> patches upstream later, in case you care about that.
>
> - Use git-submodule to import those libraries into your project's
> repo.  This is reasonably easy, but makes it hard to patch those
> libraries without creating additional repositories, which is
> inconvenient.  If you don't need to patch those libraries, it's the
> cleanest way.
>
> - Use git-subtree to import those libraries into your project's repo.
> This makes it relatively easy to push and pull changes from the
> libraries from/to upstream, but can clutter up your 'git log' a bit.
>
> I expect that for your purposes, any of the three options would work fine.
>
>> I plan to distribute the basic work needed by my application.
>> Basically, I'm building an automated process to get a e-commerce
>> website with generated Flex (Flash) views. This process is mainly
>> based on Git/Shell/Rake/Ruby commands.
>>
>> I won't distribute the source code of my own e-commerce website.
>>
>> But my problem wasn't about redistribution... RestfulX is a tool for
>> code generation. It needs some input and generate Flex code as output.
>> Then I compile Flex code to get a Flash executable (.swf / .swc). I
>> want to manage everything with versionning, but regarding the merge, I
>> just want to merge the executable in the destination repository, not
>> all the stuff used for code generation.
>
> It's very rare with git to commit your output files into a repository.
>  You can do it, but it's rare.  Most people just put the numbered
> binaries up in a directory on a website somewhere.  Version
> controlling binaries any other way doesn't really add anything, since
> 'git diff' and friends aren't much help, and the output files are (by
> definition) possible to reconstruct from the source code, so if you
> lose them, it's not a big deal.
>
> If you really want to do it, then you will probably want to at least
> put the output files on their own branch (as you suggest) or even into
> their own repository (so that people cloning the source repo don't
> have to download tons of binary revisions that they won't be using).
>
> Hope this helps.
>
> Have fun,
>
> Avery
>
