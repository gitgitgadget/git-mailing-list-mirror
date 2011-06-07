From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Tue, 7 Jun 2011 21:36:02 +0200
Message-ID: <201106072136.03964.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <7vtyc160ha.fsf@alter.siamese.dyndns.org> <1307468628.12888.81.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU24e-00049z-K9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab1FGTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:36:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60347 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab1FGTgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:36:15 -0400
Received: by bwz15 with SMTP id 15so46120bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vdIAXlB6W0HN9hswfR3/QuLOadV48JkDLBcG1V4lhaw=;
        b=lD5JHdigSogq9jDNmbsll7dTzOHUrQtCIiqvPeqSY4X3fRLGX7VaI10MaE4+3Sdvu5
         pp3i7F9y66sCSS+xTppkuaMVLJXWp+XBPQzBLOGxai05yNhZbR1s2OFImEl8681ZOA6E
         pk66oWdt9+V4ogLpN7gJ5r40Pks//GtmtHT9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Z78L8aT1TonxRX4Xuo8TozwDamhOQgeeY8Cvi44WSx2Nde58iMnypI7VYjxLQJ8SNb
         EhdYIf20LpcfqoPTKuf1odfnCqBdauQpoTn/JateUKZcrEuYFPH/3HvYjqErWh74eHY/
         2eWfg4j/+mqZ8G6+7+ZUmjk5ts0dEBXEIxYAE=
Received: by 10.204.114.144 with SMTP id e16mr2713371bkq.119.1307475373632;
        Tue, 07 Jun 2011 12:36:13 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id 16sm518749bkm.14.2011.06.07.12.36.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 12:36:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307468628.12888.81.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175259>

On Tue, 7 June 2011, Drew Northup wrote:
> On Tue, 2011-06-07 at 10:00 -0700, Junio C Hamano wrote:
>> Drew Northup <drew.northup@maine.edu> writes:
>> 
>>> On Tue, 2011-06-07 at 08:44 -0500, Jonathan Nieder wrote:
>>> ...
>>> If this is what you are proposing then we should be working on a
>>> "gitweb_config.perl" manpage and not a "gitweb.conf" manpage. I know a
>>> fair number of people around here put priority on the former and would
>>> just as soon ignore the latter. That's what your proposed change says to
>>> me (while I also understand that your own position is likely far more
>>> nuanced than that).
>> 
>> Hmm, do you want to have two (and then three, see below) separate manpages
>> that essentially describe the same thing, and refer to each other when
>> they talk about the precedence order?
> 
> No, I am just saying that if this isn't primarily meant to be
> about /etc/gitweb.conf (which is what I was told to use here on this
> very list) then we shouldn't name it after gitweb.conf,

We have to name it somehow.  For example ssh_config(5) is named after 
system-wide settings file, while it describes also user settings in
.ssh/config.  We would follow this example with gitweb.conf(5)

A bit closed, gitignore(5) and gitattributes(5) both are named after
in-tree file '.gitignore' and '.gitattributes', but describe also
private $GIT_DIR/info/exclude (not ignore!) and $GIT_DIR/info/attributes
respectively.


Anyway we can use symlinks or hardlinks (or just a plain copy) to have
this manpage under both gitweb.conf(5) and gitweb_config(5) or 
gitweb_config.perl(5).  There is precedent: many function manpages
are grouped together.  For example printf,  fprintf, sprintf, snprintf,
vprintf, vfprintf, vsprintf, vsnprintf all use single printf(3) manpage.

But that is better left for a separate commit, if we decide to do this.

> nor should we focus on gitweb.conf

Manpage describing gitweb.conf also describes gitweb_conf.perl.  The
difference is minuscule, so it is IMVHO better to cover both with one
manpage, and add a few paragraphs about precedence etc.  Isn't it?

> (the removal of the gitweb.conf we are then 
> effectively deprecating can be discussed later; I have already voiced my
> opinion on this strategy of ignoring /etc/gitweb.conf but still having
> it anyway and been summarily declared insane).

The problem is backward compatibility.  To not repeat myself, see my
thoughts on this issue later, at the end of this email.

> 
> The change he made isn't, to me anyway, one of precedence order but is
> one of focus and theme. Perhaps most people around here aren't trained
> to hew so closely to the stated purpose of a work as I am and therefore
> don't see the change he suggested as starkly. So be it. 
> I really don't like starting work on something for a project because I
> was told that (1) it was needed and, (2) it would be welcome only to
> find that neither statement was particularly true. I'd strongly prefer
> to have been told from the outset "Don't bother to document that, as
> you're the only one using it that way," and, "Document this instead, as
> just because you're not using it doesn't mean that we don't think
> everyone else should be."

Actually it both was needed and welcome.  Thanks again for your work.

The fact that your hard and welcome work on gitweb.conf manpage with
small additions (which you don't need to put yourself; we can do it
instead) is more general manpage about gitweb config files is a happy
thing.
 

>> I vaguely recall that there was an effort to document /etc/gitweb.conf as
>> a mere "fallback default", not a "system-wide configuration file", which
>> is what it is, and also to introduce a true "system-wide configuration" as
>> a separate file, so that the system-wide one will be read, and then either
>> per-instance gitweb_config.perl or the fallback default /etc/gitweb.conf
>> will update it. What happened to that effort?

If the "version C" effort, namely introducing gitweb-common.conf in

  [PATCH/RFC 2/2 (version C)] gitweb: Introduce common system-wide settings for convenience
  Message-Id: <201105261658.20140.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/174424/focus=174517

in thread titled

  [PATCH 0/2] gitweb: Improve handling of configuration files

is not in cooking stage, but fell into cracks, I can always resend said
patch.
 
> You shot it down, that's what. Or more correctly you shot down the use
> of /etc/gitweb.conf as a system-wide source of default settings instead
> proposing that it be used as a fallback (?) and that
> an /etc/gitweb-defaults.conf (or something like that) be used as a
> per-item default (or at least that's what I got out of what was said).
> I'm not sure what to think of that, but I haven't had the chance to test
> that patch-set in any case, much less incorporate it into the
> documentation. All of that would come after I'm no longer confused as to
> what the intended end-result would be.
>> 
>> In any case, with the current design, /etc/gitweb.conf is _not_ the
>> system-wide configuration file but it is a fallback default for instances
>> that do not have per-instance configuration, so the quoted part would need
>> rewording anyway, I think.
> 
> And THAT is the problem. If it isn't a system-wide configuration file
> then let's stop putting it in /etc, deprecate it, and get it over with.
> I didn't even know that to be the case when I started writing this, I
> was just trying to make more readily available the advice I'd been given
> on this list. Only after getting started did I learn that gitweb treats
> a file in /etc like nothing else I normally use (aside from
> adduser/useradd's use of /etc/skel as a directory template).

What about /etc/bashrc ?  Isn't is treated as fallback, and you have to
source it explicitly?

Anyway, because of backward compatibility (bug-compatible) we have to
name new system-wide config file /etc/gitweb-common.conf, fallback config
be at /etc/gitweb.conf, and per-instance config file gitweb_config.perl
Note that these are only defaults; they can be overridden at build time
(though you cannot change names of respective environmental variables).

Perhaps at some flag day (1.8.0 is probably to close) we can change it so
that system-wide config file is /etc/gitweb.conf, per-instance config file
(overriding system-wide settings) is gitweb_config.perl, and fallback
system-installed config file used if per-instance config file does not
exists is /etc/gitweb_config.perl

But still the manpage should IMVHO be gitweb.conf(5)!

-- 
Jakub Narebski
Poland
