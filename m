From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: How to deal with historic tar-balls
Date: Sun, 01 Jan 2012 01:27:20 +0100
Message-ID: <4EFFA868.50605@dbservice.com>
References: <4EFF5CDA.5050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nn6eumtr <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 01:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh9Gx-0007GD-Ab
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 01:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861Ab2AAA11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 19:27:27 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58638 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2AAA10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 19:27:26 -0500
Received: by eekc4 with SMTP id c4so14517842eek.19
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 16:27:24 -0800 (PST)
Received: by 10.213.26.213 with SMTP id f21mr2352373ebc.27.1325377644836;
        Sat, 31 Dec 2011 16:27:24 -0800 (PST)
Received: from calvin.local (gw.ptr-62-65-141-13.customer.ch.netstream.com. [62.65.141.13])
        by mx.google.com with ESMTPS id u53sm121770163eeu.6.2011.12.31.16.27.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Dec 2011 16:27:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111123 Thunderbird/9.0
In-Reply-To: <4EFF5CDA.5050809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187819>

On 12/31/11 8:04 PM, nn6eumtr wrote:
> I have a number of older projects that I want to bring into a git 
> repository. They predate a lot of the popular scm systems, so they are 
> primarily a collection of tarballs today.
>
> I'm fairly new to git so I have a couple questions related to this:
>
> - What is the best approach for bringing them in? Do I just create a 
> repository, then unpack the files, commit them, clean out the 
> directory unpack the next tarball, and repeat until everything is loaded?
>
> - Do I need to pay special attention to files that are renamed/removed 
> from version to version?
>
> - If the timestamps change on a file but the actual content does not, 
> will git treat it as a non-change once it realizes the content hasn't 
> changed?
>
> - Last, if after loading the repository I find another version of the 
> files that predates those I've loaded, or are intermediate between two 
> commits I've already loaded, is there a way to go say that commit B is 
> actually the ancestor of commit C? (i.e. a->c becomes a->b->c if you 
> were to visualize the commit timeline or do diffs) Or do I just reload 
> the tarballs in order to achieve this?

There is a script which will import sources from multiple tarballs, 
creating a commit with the contents of each tarball. It's in the git 
repository under contrib/fast-import/import-tars.perl.

tom
