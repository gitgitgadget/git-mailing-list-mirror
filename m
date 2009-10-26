From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Mon, 26 Oct 2009 14:42:23 +0100
Message-ID: <9accb4400910260642w360e2879vd3b1b1efc3613a13@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <19168.49405.775024.649626@lisa.zopyra.com>
	 <19168.50232.47935.864407@lisa.zopyra.com>
	 <8c9a060910221351w12e6c610kb842263e1c02ea63@mail.gmail.com>
	 <26ae428a0910221358r47434b4uf7ec71f9376b9f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Helwig <jacob.helwig@gmail.com>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2PqB-0003FN-5o
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 14:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZJZNmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 09:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbZJZNmU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 09:42:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48634 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZJZNmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 09:42:19 -0400
Received: by fxm18 with SMTP id 18so12059367fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/sgR4nSFJ8sMyQ/sqYHZ6rMWxQVQ8jztPlH8kFkE58g=;
        b=LfTnGtfQKPREfmFrkSM81+va0INNfLuuVhkgmanUtwKSt5EjZcMQTQ0HpOhJ0ix5DA
         BEOoughH2Mc48xyeyH5/+yiABTSg857TX+7oX6/1HvShT4OwmlXWNqLpoGPPoS+v9jJ1
         XvsLyya2+ooLSJTypjQYKXcFJnAs1muCZzwOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cYc1XGNkfGmzDAkj98AlJ2YmvZU9gom148jzqtGSlosGz/LQS3B3zLGh2N5+UKFy60
         xv+F6CXr8hpgFsHSuXGvVtfosJ7u5Wp6qQ2nsNVMnVmIMWAsgEPyd5hD7+ngRMV6AAwq
         23zKKmhcQ4QxC8zhdyDzcC2J+7a52iyr1aLBM=
Received: by 10.204.8.138 with SMTP id h10mr5917248bkh.187.1256564543894; Mon, 
	26 Oct 2009 06:42:23 -0700 (PDT)
In-Reply-To: <26ae428a0910221358r47434b4uf7ec71f9376b9f75@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131249>

On Thu, Oct 22, 2009 at 9:58 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
>> git merge --squash topic

>> rebase --interactive it excellent for cleaning up history, especially [...]

> Brilliant, thanks everybody!! I'll go and back up my database and have
> a play with these options.


I don't think you need it.
when you rebase or squash git don't throw away your commits

when I do things like that I usually create a new branch to do my tests

if I'm happy with the result I can do

git checkout myRealBranch
git reset --hard myTestBranch
# do the push/svn dcommit/whatever

if I'm not happy I can start all over again just doing:

git checkout MyTestBranch
git reset --hard myRealBranch

regards,
Daniele
