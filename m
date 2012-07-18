From: "Thomas Hager" <duke@sigsegv.at>
Subject: Re: clone URL missing in gitweb
Date: Wed, 18 Jul 2012 16:39:25 +0200
Message-ID: <20120718163925.79825k3b7o7lcfj1@webmail.moger.at>
References: <1342591638170-7563176.post@n2.nabble.com>
	<20120718085853.1702340b2uu0gmnh@webmail.moger.at>
	<1342600220487-7563196.post@n2.nabble.com>
	<20120718105902.93105axz8oj5a5ee@webmail.moger.at>
	<1342607206983-7563199.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 16:39:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrVPe-0000sg-6L
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 16:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab2GROjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 10:39:33 -0400
Received: from minbar.sigsegv.at ([83.64.197.38]:33219 "EHLO minbar.sigsegv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab2GROjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2012 10:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sigsegv.at; s=default;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:References:Subject:To:From:Date:Message-ID; bh=s/AxAKAD5D/pR08bPughMiNxxB6HM3N2M5YKnOTTPj0=;
	b=hNNsNXEOLlkZKz/zdEV194UTTaNtlIBrEulcEZh56BpAAgxDGUsTvXPoNAzfcBffX1+6wYa6E2YMMzlGcQSMkB1M8O6aqu4ewf8zGtl6QwXjT5J5dq1YhPYv3TbKnHR2+dM5VJQz4U/V9k7pDdHCvkYe6wROpcmghjUI7YGjwbG3FqUKCpJy4V/RfXVlCfm7QtLMwV2dM1x+M1aCUBflfnf4oXRWcZweQDb3dNubTs1COpFKTFBXn3h/0FQtyGbyf/WvQHZKUO2LPX54Fy9GmR9FvQcYaZciJv8hxLn9bhbnMKxBQa9Vipd5gd7I9tYrq/gKAfRDpHKQ+f0PQ/3Mbg==;
In-Reply-To: <1342607206983-7563199.post@n2.nabble.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201694>

Quoting baluchen <murugan.bala@gmail.com>:
> I verified the entries and they seems to be correct. But the clone and its
> URL is still now showing when browsing project summary page via gitweb
well, unless you at least post the most relevant options of your  
gitweb config, i'm afraid i cannot help you. maybe a snippet of mine  
gives you a hint:

##
##  gitweb.config.pl -- gitweb Perl configuration
##
our $projectroot = "/var/lib/git/repositories";
our $projects_list = "/var/lib/git/projects.list";
our $site_name = "Git Home";
our @git_base_url_list = grep { $_ ne '' } ("https://git.company.org/git");
[...]

with this config, gitweb displays the clone url of a repository  
"dummy.git" located in "/var/lib/git/repositories" as

https://git.company.org/git/dummy.git

bye,
tom.

-- 
Thomas "Duke" Hager                               duke@sigsegv.at
GPG: 2048R/791C5EB1            http://www.sigsegv.at/gpg/duke.gpg
=================================================================
"Never Underestimate the Power of Stupid People in Large Groups."
