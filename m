From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Tue, 20 Apr 2010 20:14:15 +0200
Message-ID: <201004202014.19477.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004191243.24209.jnareb@gmail.com> <20100419115113.GC3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Apr 20 20:14:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Hy5-0001wL-81
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 20:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0DTSOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 14:14:35 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:35474 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab0DTSOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 14:14:34 -0400
Received: by bwz25 with SMTP id 25so7098848bwz.28
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=q5PeFSgGTk5WrdSf2W+4kRNgHqowKo9ej/YI1rULD9E=;
        b=RhOp4I8sKNSuBIfOiyRFoLfEVgJ5W8WJ/j/3//rrnjtyv/UP8Q6ecuOre7uzmlb6zy
         6DBhgHLgv2L6N0kyni3HO5QiquVJa889VOPR9734DyUI8g8X8o26N/w1f85Fa59NY3Kv
         3RXRO2gb5PMzHK9RXAtuACYWUsvsavOzCKyaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qjtrH87VgZiOdnr6o1g5jm/5P6qhnrhbMWgxnUQEtTUcRTvqj02MiJ9Xlj512sE66c
         cgko9QyLHPctBXlwQDBtjCSBDieKIn359OZkKWDDtLdBD0I2HG/i46eYKwemi4wLUvPW
         qUbOpyzc8h5sRpoKC0ZfX/9wNfPoUaH4Is1t4=
Received: by 10.87.67.13 with SMTP id u13mr5915429fgk.66.1271787272656;
        Tue, 20 Apr 2010 11:14:32 -0700 (PDT)
Received: from [192.168.1.13] (abvf202.neoplus.adsl.tpnet.pl [83.8.203.202])
        by mx.google.com with ESMTPS id 4sm2500749fgg.12.2010.04.20.11.14.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 11:14:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100419115113.GC3563@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145391>

On Mon, Apr 19, 2010, Petr Baudis wrote:
> On Mon, Apr 19, 2010 at 12:43:22PM +0200, Jakub Narebski wrote:
>> On Sun, Apr 18, 2010 at 21:56 +0200, Petr Baudis wrote:

>>> If the project is a success, I wanted to use it for mob branch editing
>>> on repo.or.cz. It could also be used as open-source Gist alternative.
>> 
>> For that you would need editing file / editing contents action, but
>> this is explicitely excluded in current version of Pavan's proposal :-(
> 
> Is it? I see it only being omitted.

At the end, in the section which describes what would be not included
in the project, there was editing files excluded from project.

Which is a bit strange because you need some kind of web editor (even
if it is simply textarea) for the commit message if this "Web Client"
is to implement [git commit]...
 
>>> But it needs to be coded so that it does not require an actual checked
>>> out copy (which shouldn't be too much hassle).
>> 
>> It would require using 'git hash-object -t blob -w --stdin' (from body
>> submitted via POST from textarea) plus 'git update-index --cacheinfo'.
> 
> Yes. Not a whole lot of effort, seems to me. A downside is that you
> cannot use the working tree - index dichotomy, but life isn't perfect.

What do you mean here by "working tree - index dichotomy"?
 
>> There is however complication that you would need to do open2/open3
>> because git-hash-object would require bidirectional communication unless
>> you would use temporary file (command_bidi_pipe in Git.pm, untested).
> 
> I think even just going through a temporary file is fine for initial
> implementation.

It is not that difficult.  You can use IPC::Open2 (which is in core)
and IO::Handle (for easier coding; using IO::Handle is not strictly
necessary), like that:

  use IPC::Open2 qw(open2);
  use IO::Handle;

  ...

  my $pid = open2($out, $in, git_cmd(), 'hash-object', '-w', '--stdin');
  $in->printflush($cgi->param('textarea'))
     or die...;
  my $sha1 = $out->getline();
  chomp $sha1;

  close $out;
  waitpid $pid, 0;

Then you would need:

  system(git_cmd(), 'update-index', '--cacheinfo',
         '100644', $sha1, $pretend_path)
    or die...;

Not tested!
-- 
Jakub Narebski
Poland
