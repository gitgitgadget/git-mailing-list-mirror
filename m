From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: exporting the last N days of a repository
Date: Mon, 3 Nov 2008 11:46:52 +1030
Message-ID: <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
	 <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 02:19:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwo5t-0001fC-S5
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 02:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbYKCBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 20:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYKCBQy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 20:16:54 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:49096 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYKCBQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 20:16:53 -0500
Received: by yw-out-2324.google.com with SMTP id 9so888737ywe.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JiRLnq0+IxqueKUnggcJ4QZAH8qvDUkmB8L+i+BCqM8=;
        b=jh9YjTpuU9emVkgYuy44+5RbDG69g9Fl0sA8uCVswKHS77XymRbOsdMezFVNGApS1u
         mhvEQg8py3WCn5Bh5nBZbIFXoEE4LHNNZ21pZkDChmE9uJwMluwV97K6kwQQSO5zMSZ/
         trF4/duSulU3VhMd94wxTFKCEybASLCVa+koA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=VDqyNgvIZ224tkeHByheidpf9Z1bkJZ7TAzuGhpk68yUbXw6xrDEYUM1hRxqXjMGXq
         7cHiqnjRemGUQxCrgBaVCD/NqXcFjxQ126giMRDgcFcA0lOSRT2OQtGpqEubxHVh9GoX
         kAWCDdyYYVOs7Tj6F5CvpQme+Rux7xIGR7l9w=
Received: by 10.151.12.1 with SMTP id p1mr6328418ybi.177.1225675012364;
        Sun, 02 Nov 2008 17:16:52 -0800 (PST)
Received: by 10.150.181.6 with HTTP; Sun, 2 Nov 2008 17:16:52 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99894>

On Thu, Oct 30, 2008 at 1:40 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 29 Oct 2008, Geoff Russell wrote:
>
>> I want to export "the last N days" of a repository to create a copy
>> which has an origin which is the state of the repository N days ago and
>> has all the history between then and now.
>>
>> Can fast-export do this?
>
> Yes.  See the --since=... option.

Sorry, I didn't explain what I want very well.  N days ago I had a
working directory in
a state S with files F1,F2,F3,...    I want to dump all the history
before then so that
this is my new starting point, so I want to keep all changes since
then.  In general,
this is impossible if there are multiple branches which influence what
happens between
N and now, but in the simple non-branching case it should be possible.

Fast-export with From..To revisions (or with --since=...) just gives changes
since the point N days ago.

Basically I'm trying to do an "rcs -o:1.xyz" where xyz  is
a version and I want to prune before that to shrink a large and unwanted
history.

Thanks,
Geoff Russell



>
> Hth,
> Dscho
>
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
