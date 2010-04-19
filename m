From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Tue, 20 Apr 2010 01:14:05 +0200
Message-ID: <201004200114.07506.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004191900.12529.jnareb@gmail.com> <u2ze72faaa81004191055t13ad6f2hbdcc319260cbabcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 01:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O40Aa-00074o-Mv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 01:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139Ab0DSXOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 19:14:18 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62758 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0DSXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 19:14:17 -0400
Received: by bwz19 with SMTP id 19so24440bwz.21
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NbGOsyvoTwMEnSOz67MGy7HJrvIQDEekEFz1tF3cmso=;
        b=TuPP0wftr70lfaTfSBkiqmRXY3f5I3XCogNLamINPzMAionAHh7G5tuopjOGMIj/7L
         Bev7u1Chtq070l19LOD1M5beys+TKgrOB2ri2HQJ/Ht1Kd7RBTN8lHyB7dm0e22+cUfA
         IkJqjbhQWMvkfE8qAWAYnmT8leIU8yHvfWIuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OyBdnha3DubZHMcl3E+7cSPkctTegLRGd45XdZBgqluVss00zxmSLZttFaul+vpgx7
         n6oSXfL4GYXtmQAUBmpBszlqK+EIcM7R0pVL61e0qicuX2/f5gyB9ErlXgifHo8o+ua0
         z6HWU+bux87lKqzocxQUsLXmpVA+fx4k1hhng=
Received: by 10.204.81.80 with SMTP id w16mr155767bkk.84.1271718854866;
        Mon, 19 Apr 2010 16:14:14 -0700 (PDT)
Received: from [192.168.1.13] (abvh23.neoplus.adsl.tpnet.pl [83.8.205.23])
        by mx.google.com with ESMTPS id 13sm3423915bwz.7.2010.04.19.16.14.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 16:14:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <u2ze72faaa81004191055t13ad6f2hbdcc319260cbabcf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145340>

On Mon, 19 April 2010, Pavan Kumar Sunkara wrote:
> 2010/4/19 Jakub Narebski <jnareb@gmail.com>:
>> On Mon, 19 Apr 2010, Pavan Kumar Sunkara wrote:
>>> On Mon, Apr 19, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:

>>>> First, a question: do you feel proficient enough in Perl (and in w=
eb
>>>> scripting in Perl), or do you prefer other programming language fo=
r
>>>> web, like e.g. Python? =A0If you feel like you would do better pro=
gramming
>>>> in Python (or PHP, or Ruby) rather than in Perl, you could write t=
he
>>>> main part of this GSoC project in said language, and provide only =
hooks
>>>> into gitweb (with the help of developers on git mailing list).
>>>
>>> I don't know perl but learning it and becoming proficient in it won=
't be a
>>> matter for me. I believe I am a fast learner and I am a computer sc=
ience
>>> student in the top university of India. I learnt python in an hour =
and
>>> became proficient in it by a week. So learning perl won't be a matt=
er for
>>> me.
>>
>> I can agree that you would be able to learn Perl in a week. =A0I do =
not
>> think however that you can become proficient in Perl (and neither in=
 any
>> other non-trivial programming language) in such short time. =A0The q=
uestion
>> remains if you can be proficient enough for the task in question...
>=20
> I can learn perl in 3 hours. Becoming proficient in perl is just
> knowing about all the majorly used inbuilt functions and libraries.
> Coming to the concepts of programming, I already know a lot about it
> along with data structures and algortihms. So you need not doubt me o=
n
> this.

You can (probably) learn Perl *syntax* in 3 hours.  You perhaps can
learn to start to write clean, idiomatic Perl within a week, provided
that you find good books (like "Higher-Order Perl", which can be found
at http://hop.perl.plover.com/book/, or other Perl books from O'Reilly)=
=2E
Be proficient in Perl in that short time?  I don't think so.

I guess that you can learn enough Perl for this project, but I'd really
prefer for you to be proficient in Perl already...
=20
>>>> "It aims at developing functionalities for working on a git reposi=
tory."
>>>> Not only this is not grammatical, but also doesn't tell us the goa=
l
>>>> of your project. =A0Is it something to edit files and create commi=
ts via
>>>> web, be to git-gui what git-instaweb is to gitk? =A0Is it about ed=
iting
>>>> gitweb-specific configuration, like README/README.html and 'descri=
ption'
>>>> file from web browser? =A0Is it managing git repositories, i.e. cr=
eate,
>>>> fork or clone and mirror repositories, something that Gerrit does =
for
>>>> repo.or.cz (repo.or.cz uses gitweb for viewing repositories)?
>>>>
>>> I think you understood it from the later part of my proposal.
>>
>> Yes, I found it in later parts of proposal, but don't you think that
>> this goal of this project should be stated upfront, so that one can
>> know what this project is to be about from project description itsel=
f?
>=20
> I thought it should be described later in the "Describe your project
> in more detail" section.  So, I didn't go into details here.

Nevetheless it is a place to describe *specific* goal of project here,
in one to two sentences.  No marketing buzzwords here :-PPP
=20
[...]
>>>>> =A0 =A0* modules (dir) -- directory containing the write and read=
 modules.
>>>>> =A0 =A0* lib (dir) -- some basic files like config, error_handler=
,
>>>>> templater, redirecter, htmlHelper etc..
>>>>
>>>> I'm not sure about modules/ directory: wouldn't lib/ be enough?
>>>> What needs to be in modules/ that cannot be put in lib/?
>>
>> I guess (please correct me if I am wrong) that lib/ would contain mo=
dules
>> *required* by gitweb, and modules/ would contain *optional* modules
>> needed for extra functionality (for extra features).
>=20
> You are half correct.
> lib/ contains modules *required* by gitweb
> modules/ contains actions *performed* in gitweb like commitlog,
> snapshot etc.. (write actions too)
>=20
> Maybe I will rename it to actions/ to not to be confused.

I don't understand why actions are not to be in lib/, like e.g. SVN::We=
b
(http://p3rl.org/SVN::Web) has SVN::Web::Blame module for 'blame' actio=
n?
Although I am not sure if SVN::Web is a good example of coding practice=
s
and code organization.

>>>>> =A0 1. Add existing repositories to the gitweb -- This will list =
the
>>>>> =A0 =A0 =A0given repo into gitweb config
>>>>
>>>> Note that if gitweb scans for repositories ($projects_list is
>>>> a directory, not a file with the list of projects), gitweb would d=
etect
>>>> new repository automatically. =A0This feature (autodetecting
>>>> repositories) is fore example requirement on git.kernel.org.
>>>>
>>> Let us say if there are multiple repositories in multiple paths, wo=
uldn't it
>>> be good to add a single project. This option will be available alon=
g with
>>> scanning $projects_root.
>>
>> If gitweb is configured to scan for repositories, adding existing gi=
t
>> repository to gitweb doesn't make sense. =A0If gitweb is configured =
to
>> use static file with list of repositories, of course it would make
>> sense... but then the question is how would one specify location of
>> a new repository to add.
>=20
> How about like this ?
> We will have a static file with list of projects. All the repositorie=
s
> in scan path will be added to this list. Then we will also have an
> option to add an existing repository which can be done when the user
> specifies a relative or full path to the repository.

O.K. that is a good idea: make gitweb scan for repositories, and presen=
t
user with the list of them to add to static list of visible projects=20
(repositories).

>>> Yes. I will not be doing it in GSoC and it won't be a part of gitwe=
b, But I
>>> hope to provide an authentication wrapper for gitweb in future.
>>
>> Well, unless there would be time for it after you finish all other w=
ork,
>> but it is a bit unlikely.
>=20
> I don't think so. I would like to constantly contribute to gitweb.

I'm sorry, we seem to have a bit of misunderstanding here.  What I mean=
t
that this should be in the "optional" part of GSoC project, so it would
be worked on during GSoC only after everything else is done.  Because t=
he
scope of this project is quite wide, I though it unlikely to have time
left at the end of GSoC after finishing all other more important featur=
es.

I did not mean to say that you would be unlikely to contribute after GS=
oC
finishes.
=20
--=20
Jakub Narebski
Poland
