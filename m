From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 21:01:53 +0200
Message-ID: <201105122101.54710.jnareb@gmail.com>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu> <201105122008.53322.jnareb@gmail.com> <1305225191.24667.101.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu May 12 21:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKb91-0001r0-JS
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab1ELTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 15:01:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab1ELTBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 15:01:50 -0400
Received: by bwz15 with SMTP id 15so1549777bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2Qr9L1C0xFSPGavM/H56sacHlZLJMx28z0Z2Q0i3By4=;
        b=r5Gge91Jr79aNvBKZTfSSK1Ulwd+9qPG65Cpj7Gn+SdNmgNZecKsMt71ICHjvtR3Sj
         GoXyCIaWkVx03ZEdZ29BAczvSjZcaYcQj7CHsU21/GuyRrIU6qcczMy/G6erhWWw5sno
         0WEuRI6jVYtIjnJZOHT8j4YMLCHqms0/bbywg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TanVM6nO+cbhKkOKIpZaMDD835CRR8ptb8Z5leusPnxOD5D9Bnbdm+/l9I/Bc/V0L/
         Y1vixfiA4jRbc3kckmvkD/pc+MpYMFCxxS39upV7vR/gnBWE7AyOkVFqYjxUcd1YLYw5
         EErGIxAm+3yxJ8uDPs43g7UsYM0+S1zVC5dPA=
Received: by 10.204.154.74 with SMTP id n10mr567852bkw.33.1305226909001;
        Thu, 12 May 2011 12:01:49 -0700 (PDT)
Received: from [192.168.1.13] (abvl88.neoplus.adsl.tpnet.pl [83.8.209.88])
        by mx.google.com with ESMTPS id 16sm899494bkm.18.2011.05.12.12.01.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 12:01:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1305225191.24667.101.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173494>

On Thu, 12 May 2011, Drew Northup wrote:
> On Thu, 2011-05-12 at 20:08 +0200, Jakub Narebski wrote:
>> On Wed, 11 May 2011, Drew Northup wrote:
> 
>>> +
>>> +The syntax of the configuration files is that of PERL, as these files are
>>> +indeed handled as fragments of PERL code (the language that gitweb itself is
>>> +written in). Variables may be set using "'our $variable = value'"; text from
>>> +"#" character until the end of a line is ignored.
>> 
>> I think it would be nice to have an example here, something like:
>> 
>> -----
>> our $site_name = 'My Gitweb'; # or 'localhost'
>> -----
> 
> Looks reasonable to me...

Well, this is very much off the cuff example; I hope for a better example,
though it doesn't matter much here...

>>>                                                    See the perlsyn(1) man page 
>>> +for more information.
>> 
>> Is this how other manpages should be referenced in AsciiDoc?

Shouldn't we use some 'link:perlsyn[1]' or something like that here?

>> 
>> BTW. What is &#8211;, and could we write it using something more readable?
> 
> That's an en dash. A lot of people write it "blah - blah," but that's
> not typographically correct (and asciidoc isn't nice enough to fix it
> for us, as that would likely mess something else up). It compiles
> properly into both HTML and manpages. I didn't think that dropping the
> UTF-8 character into the asciidoc sources would go over well.

Doesn't AsciiDoc convert '--' to en-dash?  If not, perhaps adding 
appropriate definition to Documentation/asciidoc.conf and using "{endash}"
instead of "&#8211;" would be a better solution.

>>> +CONFIGURATION SETTINGS
>>> +----------------------
>>> +Standard Options
>>> +~~~~~~~~~~~~~~~~~
>>> +The following are not typically set or overridden at build time:
>> 
>> Hmmm... There are four kinds of configuration variables:
> 
> Thank you for this extraction & table.

Note that some of those variables (those below ".....") are not present
in gitweb/README and are not present in your patch.
 
>>> +Configuration Options Often Set at Compile Time
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +These configuration variables are often specified at compile time and are
>>> +defined by default in the gitweb CGI itself:
>>> +
>>> +GIT_BINDIR::
>>> +	Points where to find the git executable.  You should set it up to
>>> +	the place where the git binary was installed (usually /usr/bin) if you
>>> +	don't install git from sources together with gitweb.  [Default: $(bindir)]
>> [...]
>> 
>> I think this should be left in gitweb/INSTALL, as those are important
>> _only_ during building gitweb.
> 
> Understood, I'll have to audit the list for values like that. 

I meant here the whole (sub)section.

>>> +Configuration File Example
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +To enable blame, pickaxe search, and snapshot support, while allowing
>>> +individual projects to turn them off, put the following in your
>>> +GITWEB_CONFIG file:
>>> +
>>> +        $feature{'blame'}{'default'} = [1];
>>> +        $feature{'blame'}{'override'} = 1;
>> 
>> I think this example requires explaining upfront what does it mean to
>> allow feature override, i.e. about per-repository configuration.
> 
> Agreed, I was just pulling thing together in this step. I think that
> there are likely other worthy additions to this portion.

Right, we need some documentation about %feature, like e.g. what does
overriding means, and why 'default' needs to be array (currently).

-- 
Jakub Narebski
Poland
