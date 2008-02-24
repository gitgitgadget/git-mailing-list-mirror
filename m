From: Alberto Bertogli <albertito@gmail.com>
Subject: Re: [PATCH] Fix "git submodule status" output when "git describe"
	is not possible
Date: Sun, 24 Feb 2008 18:49:39 -0200
Message-ID: <20080224204939.GE10119@gmail.com>
References: <1202861986-1159-1-git-send-email-albertito@gmail.com> <7vprv1zn27.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 21:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTNp7-0003t7-Bc
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 21:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYBXUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYBXUvA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 15:51:00 -0500
Received: from gv-out-0910.google.com ([216.239.58.184]:26545 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYBXUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 15:50:59 -0500
Received: by gv-out-0910.google.com with SMTP id s4so462236gve.37
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=96weMxTw5nSS6UkGxBA4lVk5lbc98+7uQErpRgtDuw4=;
        b=FpKEphDTdVjpaWhy77ht46V1ij4Meo9I71ZUeMTcLiATtBf2dA+25HiDOQzfvJmrYBCaaAO616+kHqpo8+ZO1+n991eA5cl3Gd95TUwzs0LDRBkOB1SEAWAlCUzhgS6t6kURIU+nlAJs1gpCtkPywsjB39I3T2P7c5/5No53E34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XgiMj21Qh3vklZhtmoFrCRYaeLj3Xg7ONHA8Ho7kH2RrsZnQ43IOZuuYTIsVXxaHrmDJR7bW0/dHAiHl3RWG1IIoL5ekvxNddD/ldyV7NxCXBjxg5Is/rAOdcIK43DBhaRFP+8BPc5TTE2Z9eQcsfiWbtjYgXP5ucdGqely7nAw=
Received: by 10.142.73.8 with SMTP id v8mr1530701wfa.68.1203886256680;
        Sun, 24 Feb 2008 12:50:56 -0800 (PST)
Received: from gmail.com ( [200.117.160.120])
        by mx.google.com with ESMTPS id 38sm5688408wrl.41.2008.02.24.12.50.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 12:50:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vprv1zn27.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74959>

On Tue, Feb 12, 2008 at 05:01:52PM -0800, Junio C Hamano wrote:
> Alberto Bertogli <albertito@gmail.com> writes:
> 
> > When a submodule cannot be described, doing a "git submodule status" on
> > the supermodule produces unnecesary and scary output,...
> 
> I had an impression that describe got a new feature for a case
> like this recently.

I'm sorry but I've read the docs and tried with a few options and I have
no idea what that one may be.

The bug is still present on 'next' as of an hour ago.

Thanks,
		Alberto
