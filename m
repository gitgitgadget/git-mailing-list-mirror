From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: new 'refshort' format
Date: Sun, 31 Aug 2008 09:11:22 +0200
Message-ID: <36ca99e90808310011s3af5929fw5bb67be2bff4fab@mail.gmail.com>
References: <36ca99e90808291121j7b202917r2308719970668be3@mail.gmail.com>
	 <1220046116-23703-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vmyiterfd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZh70-0002Ts-6l
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 09:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYHaHLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 03:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYHaHLY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 03:11:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:48257 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYHaHLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 03:11:23 -0400
Received: by wx-out-0506.google.com with SMTP id h29so415940wxd.4
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m3D6KL01lmV0iOJ32oR+FzDtK9eyCxcXQ68ybYeJqYg=;
        b=iixqiCSGC36bTrL6FuASYPow1M2e8sXvcaLCJwGQDpYPe8saQ3WSvZhbo8py06lZnK
         tvjGVhdDK6pypzroleRpuT6w8NuOB9EJKbu6FMtCPfniWR0rmVBYVC8nxCYx+5Pf2gJ0
         sBmKLOpXMrGEIxEDpnb/4dfrVphr/hs2uK8zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MYOFPUKR6cRv7fw4LNo8eCo6oFbxs17Ix0tXsk3GPeC+OvX59vofN7Qn+/8cK8H4iT
         5cbKmPbKQAv5TzVgzRZbeYzXLVAlGAxXX/Wtxn2GcvYtJN43wLZieF1HrYrf3ex2K5Ep
         Ch5H/jVZFwoU58fsE1kK9YsSvwwBSB6NdFqas=
Received: by 10.70.13.6 with SMTP id 6mr5948194wxm.17.1220166682205;
        Sun, 31 Aug 2008 00:11:22 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Sun, 31 Aug 2008 00:11:22 -0700 (PDT)
In-Reply-To: <7vmyiterfd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94460>

On Sun, Aug 31, 2008 at 06:31, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Here is a first sketch for this idea.
>>
>> This strips from the refname the common prefix with the matched pattern.
>
> Looks quite straightforward and to the point.
>
What do you think about the ':short' modifier for 'refname' or
'*refname' instead 'refshort'? i.e. %(refname:short)

Bert
