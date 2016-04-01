From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Trouble with cat-file on tags
Date: Fri, 1 Apr 2016 11:32:42 +0200
Message-ID: <ndlf7q$ghe$1@ger.gmane.org>
References: <ndlesh$dj1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alvRl-0005sk-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 11:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbcDAJcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 05:32:50 -0400
Received: from plane.gmane.org ([80.91.229.3]:33518 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbcDAJct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 05:32:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alvRf-0005qo-9m
	for git@vger.kernel.org; Fri, 01 Apr 2016 11:32:47 +0200
Received: from 131.228.216.133 ([131.228.216.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:32:47 +0200
Received: from sschuberth by 131.228.216.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:32:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.133
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <ndlesh$dj1$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290513>

On 4/1/2016 11:26, Sebastian Schuberth wrote:

> ---8<---
> $ git tag test-tag
>
> $ git tag -l
> test-tag
> v0.0.3
> v0.0.4
> v0.1.0
> v0.1.1
> v0.1.2
>
> $ git cat-file tag refs/tags/test-tag
> fatal: git cat-file refs/tags/test-tag: bad file
> ---8<---

Alright, I just found out why that is: Lighweight tags are not stored as 
Git objects. As soon as I make it an annoted tag by specifying a 
message, "cat-file tag" do esnot display a fatal error anymore.

However, I still get information about the commit oject iintsead of the 
tag object. Is this expected?

Regards,
Sebastian
