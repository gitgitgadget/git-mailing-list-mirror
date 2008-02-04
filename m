From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 04 Feb 2008 20:12:59 +0900
Message-ID: <200802041113.m14BDLMl004301@mi1.bluebottle.com>
References: <m3lk6161jo.fsf@localhost.localdomain>
    <prvd3i9e.fsf@blue.sea.net>
    <ir15399p.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 12:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLzH7-0003lS-9e
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 12:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYBDLNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 06:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYBDLNW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 06:13:22 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:53329 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYBDLNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 06:13:21 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m14BDLMl004301
	for <git@vger.kernel.org>; Mon, 4 Feb 2008 03:13:21 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=DKXYrpVy1WEyltvJXBxnBUWc1hj2Z4yHJl5dzJoJsN538aPDisY6Sg+HDwbibPDj7
	MZBurmzTJrFf7lIo0mOPF4bun3zTKIQCCA3w48VGLeevXC/yfHZsIpxosCG6qNl
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m14BDAQ9009449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 03:13:15 -0800
In-Reply-To: <m3lk6161jo.fsf@localhost.localdomain>
X-Trusted-Delivery: <f470ee661268175433264a04fb53b463>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72491>

Quoting Jakub Narebski <jnareb@gmail.com>:

> Jari Aalto <jari.aalto@cante.net> writes:
>>  
>> -USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
>> +USAGE='[-i|--interactive] [-v|--verbose]
>> +[--whitespace={nowarn|warn|error|error-all|strip}]
>
> I would say "[--whitespace=<option>]" or "[--whitespace=<action>]"
> instead of introducing yet not agreed upon notation (this has the
> advantage of shortening synopisis, which should be short IMHO).
>
> Besides here the mutually exclusive options are naturelly delimited,
> so you can say just (I think):
>    [--whitespace=nowarn|warn|error|error-all|strip]
>
>> +[-m|--merge] [--onto <newbase>] <upstream> [<branch>]'
>> +

I tried to run "git rebase --interactive --whitespace=strip" but it does not seem to strip blank characters at the end of my lines.  Did I find a bug?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
