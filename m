From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: subversion-perl missing
Date: Wed, 28 Sep 2011 14:59:30 +0200
Message-ID: <201109281459.31689.jnareb@gmail.com>
References: <4E8066AB.7000208@gjlay.de> <m3k48vp6l7.fsf@localhost.localdomain> <4E82F18E.9080304@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Wed Sep 28 14:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8tjn-0002mM-Hp
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 14:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1I1M7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 08:59:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52266 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1I1M7l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 08:59:41 -0400
Received: by fxe4 with SMTP id 4so519954fxe.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jvj3ViSZsULB5GX/NHegBCGaTNxCw5IjEPEJDuo1kTE=;
        b=G0UnMEcrpr2FkeposecfeLYLm80ol0Tk46RTuYPVpVxzjnfJuE0LPIGwen4YAgKKpG
         Epc7m5BRFIK7MAxdL9Hel6V5Iq+nDgcelzbIs+K/4rp0/IgG7gJLcGZsYZEwdAw6kGjn
         XWB9N5jRNO3Mije6iyl9kuMVudG/+n+05oYHQ=
Received: by 10.223.49.213 with SMTP id w21mr14476960faf.44.1317214780482;
        Wed, 28 Sep 2011 05:59:40 -0700 (PDT)
Received: from [192.168.1.13] (abvu115.neoplus.adsl.tpnet.pl. [83.8.218.115])
        by mx.google.com with ESMTPS id v17sm27249730fai.18.2011.09.28.05.59.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 05:59:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E82F18E.9080304@gjlay.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182309>

On Wed, 28 Sep 2011, Georg-Johann Lay wrote:
> Jakub Narebski schrieb:
>> Georg-Johann Lay writes:
>>> Christian Couder schrieb:
>>>> On Mon, Sep 26, 2011 at 1:48 PM, Georg-Johann Lay <spam@spam.com> wrote:
 
>>>>> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
>>>>> that in subversion.tigris.org, so that I am stuck and need some hints on how to
>>>>> proceed.
>>>>
>>>> Perhaps you can try to install this module from CPAN:
>>>>
>>>> http://search.cpan.org/~mschwern/Alien-SVN-v1.6.12.1/
>>>>
>>>> or from it's github repo:
>>>>
>>>> https://github.com/schwern/alien-svn
>>>
>>> thanks for that hint.
>>>
>>> After getting that piece of software, running ./Build.PL and ./Build I just
>>> don't know what to do next.  The README doesn't say anything about how to use
>>> the built modules or how to do an install.
>> 
>> If you don't have admin privileges on the box, the best solution would
>> be to use local::lib[1] to install Perl modules in your home directory
>> for you (#perl IRC channel on FreeNode, or perlmonks are really helpful).
>> 
>> I really recommend it, together with cpanm[2] (which can configure
>> local::lib for you, via --local-lib option), though the latter is not
>> necessary.
>> 
>> [1]: http://search.cpan.org/~apeiron/local-lib-1.008004/lib/local/lib.pm
>> [2]: http://search.cpan.org/~miyagawa/App-cpanminus-1.4008/bin/cpanm
>> 
>> 
>> If you have admin privileges, I think the best solution would be
>> either find repository which has subversion-perl that matches your
>> version of Subversion, or compile subversion-perl from a source
>> package... though this might be more difficult, it has advantage of
>> being in package management.
>>  
>>> As git-svn complains
>>>
>>> ...Can't locate SVN/Core.pm in @INC (@INC contains: ...
>>>
>>> and
>>>
>>>  schwern-alien-svn-9298884>find . -name 'Core.pm'
>>> ./src/subversion/subversion/bindings/swig/perl/native/Core.pm
>>> ./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Core.pm
>>>
>>> the question is how to do the final trick of telling git how to use Core.pm
>>> (and which of the two?) and do the connexion between git and alien-svn.
>>>
>>> Sorry for the noob questions, never used perl or git before...
>> 
>> You have to install subversion-perl somewhere, not only build it.
> 
> Unfortunately, that package comes without hints on doing that.
> 
> As far as I understand, alien-svn comes with SVN sources which it uses for its
> own perl packages to provide svn stuff to perl, but don't install/build new svn
> version.

Step by step instruction.

1. Follow instructions on local::lib manpage
   http://search.cpan.org/perldoc?local::lib

   c.f. http://perl.jonallen.info/writing/articles/install-perl-modules-without-root

2. (Optional). Follow instructions on cpanm manpage, e.g. http://cpanmin.us
   or http://search.cpan.org/perldoc?cpanm

3. Install Alien::SVN from CPAN using 'cpan' client or 'cpanm', e.g.

   $ cpanm Alien::SVN

Now you are able to install Perl modules in your home directory.
-- 
Jakub Narebski
Poland
