From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Tue, 7 Jun 2011 18:41:05 +0200
Message-ID: <201106071841.05617.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <20110607134404.GA12730@elie> <1307464037.12888.49.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 18:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzLH-0008Ln-Dg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 18:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab1FGQlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 12:41:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39056 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab1FGQlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 12:41:16 -0400
Received: by fxm17 with SMTP id 17so3226574fxm.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=SjuKh37HEKEZqD8qBvQo5Hvg56unTsQpWQ6zEf80egs=;
        b=vXgFbpTbhlWKJ927R05GiPSCV8MbWzexSe19ltBkWFX2T+eV+6ALYJ2ESQerWM1Tv/
         LMrn+mO+4Qnlg8G7B5xnbwR3n5QNiON96xELLMYZupMxuIx/Vd1C11wMpJPfh3oQwWPY
         fkb7fnTvPuc5XZPXxH5o+LGtIygM8ew5j55bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Rk9NxcgAijmVL/LuJkf0riv/TkWD0Ya7k6hu1mUiQlmWtrkYc6Mv+RLgjHys/VhXaW
         ZFgrwLOhfDXFLbiMSIvsFHiFNVwr/GyUHShbVw8ZicSVD4soBDmKVU2CwrxSeOmp4xW9
         AcL8FxFN+Ms2CMj9z60ojfJ4VE9POQuu+wPKM=
Received: by 10.223.144.129 with SMTP id z1mr4441296fau.57.1307464875321;
        Tue, 07 Jun 2011 09:41:15 -0700 (PDT)
Received: from [192.168.1.15] (aeho108.neoplus.adsl.tpnet.pl [79.186.196.108])
        by mx.google.com with ESMTPS id r10sm1846040fah.26.2011.06.07.09.41.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 09:41:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307464037.12888.49.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175213>

Quick reply; more detailed responses will follow.

On Tue, 7 Jun 2011, Drew Northup wrote:
> On Tue, 2011-06-07 at 08:44 -0500, Jonathan Nieder wrote:
>> Drew Northup wrote:
>>> On Mon, 2011-06-06 at 17:12 -0500, Jonathan Nieder wrote:
>>>> Jakub Narebski wrote:

>>>>> +The location of system-wide gitweb configuration file is defined at compile
>>>>> +time using the configuration value `GITWEB_CONFIG_SYSTEM` and defaults to
>>>>> +'/etc/gitweb.conf'.  The name of the per-instance configuration file is
>>>>> +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_config.perl'
>>>>> +(relative path means located in the same directory gitweb is installed).
>>>>
>>>> Maybe:
>>>>
>>>> 	In addition to the per-instance configuration file, there can
>>>> 	be a system-wide configuration file to act as a fallback when
>>>> 	the per-instance configuration file does not exist.
>>>>
>>>> 	The system-wide configuration file is named /etc/gitweb.conf
>>>> 	by default.  Filenames for the system-wide and per-instance
>>>> 	configuration variables can be overridden at compile time and
>>>> 	run time; see the FILES section for details.
>>>
>>> This is the manpage for the system wide configuration file. If you'd
>>> like to scrap this effort in favor of something else please speak up.
>> 
>> Huh?
> 
> If this is what you are proposing then we should be working on a
> "gitweb_config.perl" manpage and not a "gitweb.conf" manpage. I know a
> fair number of people around here put priority on the former and would
> just as soon ignore the latter. That's what your proposed change says to
> me (while I also understand that your own position is likely far more
> nuanced than that).

I think this manpage is about both system-wide and per-instance config
file, just like gitignore is about both in-tree .gitignore and private
$GIT_DIR/info/exclude, like gitattributes is about both in-tree 
.gitattributes and $GIT_DIR/info/attributes,... just like ssh_config
is about both system-wide ssh_config and per-user .ssh/config.

And like all of those manpages are named after one file, just like
this manpage.

Perhaps we could even symlink/hardlink gitweb_config.perl manpage
to gitweb.conf manpage...


P.S. I am sorry that I didn't state more clear that I modified Drew's
original submission, and didn't write in more detail what I have changed.
Some of mistakes are mine, not Drew...

-- 
Jakub Narebski
Poland
