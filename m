From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Wed, 28 Mar 2012 23:35:09 +0530
Message-ID: <CACeyogf_ssqS6LdiYiopkh8UYGiBw5Cm06e-sut_y33cimiMJQ@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203272114.33122.jnareb@gmail.com>
	<CACeyoge5iVAEebwj8NHo9VF=OO10M4sG4WegngBqr6qnsYvjQQ@mail.gmail.com>
	<201203281238.49171.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxFc-0006Hl-6w
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab2C1SFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 14:05:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36798 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509Ab2C1SFK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 14:05:10 -0400
Received: by yhmm54 with SMTP id m54so937714yhm.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=su1ioEGqcPQazfu7F1qssQbUF8Zn68sle87zVY8Yb+o=;
        b=Z2f8XfNOQL8934xWC+CjggG7UEx5eJBFk4GbpT9ZS3+oAkbq3ohxsYYkVdNeSfCOQW
         0V4P2qnOImCGQ7rpaB8+vilyRYjOqp5v1vG6mWg/njCAQHsGSVaB9C/pv8oFzrTPRHlN
         v+PDxiFcIUpShhXgbUkqfbkYzP1Vk4XPYZ6fEu97t31su+8Nijb1IlnakiwVon1rfQtx
         3CvBxApjoQySig6UXd6y+6C7d7ZeORkvuVsLjeEcBWvtRchhYb+MI47dUbUr8gw3oPUF
         MfXkRcylaTtMFFg2KBBCyQRed/Y0rxN/kXGIiws1noU2Qf8PNaFZThycOh7mEUgThR0C
         QmCg==
Received: by 10.60.28.137 with SMTP id b9mr38997177oeh.57.1332957910086; Wed,
 28 Mar 2012 11:05:10 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Wed, 28 Mar 2012 11:05:09 -0700 (PDT)
In-Reply-To: <201203281238.49171.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194154>

i forgot to add this feature to employ javascript syntax highlighter
to pretty-print contents of the blob view.Here are my views regarding
which library to use . i want to stick to one or two libraries as i
dont want to  mix things  up which is a bad practise.

for DOM manipulation jquery is better than others.
for graphics representation raphael library or Dojo is better.
if one need robust Object oriented platform , Dojo is better.
Based on popularity , light weighted library jquery is pretty famous
because of its simplicity and power ,it got added advantage that
microsoft Asp.net and nokia are supporting it.
YUI is modular .
mootools lets have us our own way .. http://jqueryvsmootools.com/
please take a look at this Link.
http://en.wikipedia.org/wiki/Comparison_of_JavaScript_frameworks.

Based on the goal of the project , i would prefer jquery as it is well
tested ,robust , simple to use , widely popular,good support for DOM
manipulating , fast(performance) in most cases , even though for
graphics i would go for raphael as it have clean and neat api similar
to jquery , it has good graphics support.

please enlighten me if i'm going on the wrong track.  I am sure you wil=
l :)

On Wed, Mar 28, 2012 at 4:08 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Tue, 27 Mar 2012, chaitanyaa nalla wrote:
>
>> Dear Jakub,
>>
>> I prepared a schedule for gsoc ,please take a look and suggest me in
>> case if you feel some tasks couldn't be completed with in indicated
>> time .
>>
>> Week 1 =EF=83=A0 understanding how the whole gitweb and related serv=
er side
>> scripts are implemented , their design philosophy , coding standards=
 ,
>> documentation standards to maintain the best practise coding
>> practices.
>
> I think you need to at least skim the JavaScript part of gitweb code
> to be able to create a decent proposal.
>
>> Brainstorming sessions regarding which libraries to use on
>> specific scenarios by keeping many criteria=E2=80=99s in mind and cr=
eating an
>> abstract design on the additional features =C2=A0that have to be add=
ed.
>
> I think it would be a good idea to propose JavaScript library / frame=
work
> to use for client-side scripting in gitweb (jQuery, MooTools, Dojo, Y=
UI),
> explaining shortly why this one and not other (popularity, "weight", =
your
> knowledge, etc.). =C2=A0Though perhaps not commit to said library.
>
> You say "libraries", but I think gitweb should use single JavaScript
> library, perhaps with exception of specialized libraries or plugins f=
or
> extra stuff like Raphael.js for drawing.
>
> Also here or later there should be time for short discussion about
> marrying use of external JavaScript library to gitweb.perl script and
> to our build system (gitweb/Makefile).
>
>> Week 2 =EF=83=A0 Improving Javascript browser detection and incremen=
tal blame.
>
> Errr... gitweb does not employ browser detection. =C2=A0Well, at leas=
t not
> in strict sense; it does employ some feature detection e.g. to create
> XmlHttpRequest -- but that is what library is for, it is assumed to d=
o
> cross-browser behavior for us.
>
> Anyway improving existing features, and adding new features should be
> much later. =C2=A0The very first thing is to transform existing code =
(JavaScript
> detection, adjusting timezones and incremental blame) from hand writt=
en
> JavaScript to using JavaScript library, incrementally if possible, an=
d
> removing our own mini-library in `gitweb/static/js/lib/`.
>
> [...]
>> Week 3 =EF=83=A0Improving UI of adjusting timezone by deciding which=
 library /
>> framework to use on UI.
>
> I don't think timezone select UI needs much improvement.
>
> Anyway I think that we would either use library, or UI addons for lib=
rary
> (like jQuery UI if you choose jQuery), or plugins for library.
>
>> Week 4 & 5=EF=83=A0 design and implementation of client side sorting=
 of tables
>
> That should be fairly easy (though I am not sure if "1 week" easy).
> This is what "sorttable" does in jQuery and I guess also other librar=
ies
> (built-in or via plugin); what needs to be adjusted is replacing or
> overriding (perhaps via onclick handler) links to server-side sorting
> by trigger to client-side sorting. =C2=A0Keeping table zebra-colored =
might
> be a problem, but I think JavaScript libraries solved that already.
>
>> and client side syntax highlighting of the blob view by handling how
>> git web splits the output into lines and providing line numbers.
>
> That can be hard, and here there might be question of choosing separa=
te
> library for JavaScript-based source highlighting. =C2=A0There is also=
 a
> question of integrating it with server-side source highlighting (turn=
ing
> off JS-based if server side already does syntax highlighting, and usi=
ng
> the same CSS).
>
>> Week 6 =EF=83=A0 testing the code robustly on as many browsers as po=
ssible
>> (with their versions) and documenting the code neatly .
>
> This is a good idea.
>
>> MidTerm Delivarables : Improving javascript browser detection,
>> incremental blame,ui of adjusting timezone .Adding client side sorti=
ng
>> of tables and client side syntax highlighting of blob view .
>
> I would be happy if at midterms you would have existing JavaScript
> features ported to JavaScript library, without adding any new feature=
s
> or extending existing ones.
>
>> Week 7 & 8=EF=83=A0 Using deferrands or queues in the interactive bl=
ame to
>> avoid the editing of DOM which happens asynchronously to avoid
>> locking
>
> O.K. =C2=A0You will have to check chosen JavaScript library documenta=
tion
> for its name for such things; different libraries uses different name=
s
> for asynchronous processing helpers.
>
> This might be hard part, but if you think you can do it in week
> or two...
>
>> and automatic extending of clickable area for places where the
>> link is constrained to a single cell or of that type.
>
> Nice. =C2=A0This also means that on server side we can remove link wi=
thin
> link (which does not work in some overly strict web browsers), but
> this server-side change doesn't need to be done by you.
>
>> Week 9 & 10 & 11=EF=83=A0 design and implementation support for grap=
hical
>> representation of history in log ,shortlog and history using Raphael
>> javascript library, adding UI to compare arbitrary commits in the pa=
ge
>> using commitdiff view similar to MediaWiki page history view and
>> creating a side by side diff from unified diff in javascript so that
>> switching between unified diff and side by side diff could be handle=
d
>> on client side.
>
> O.K., though graphical representation of history might be harder than
> that (than allowed 1 week or 2).
>
> Side-by-side diff is just porting from Perl to JavaScript.
>
>> Week 12 =EF=83=A0 documentation , writing a detail report , testing
>> exhaustively and checking whether the written code follows the
>> characteristics .
>> Note: considerable amount of time will be spent each week
>> concentrating on design for adding a new feature since its design
>> greatly affects many things.
>
> --
> Jakub Narebski
> Poland
