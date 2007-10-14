From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 21:12:43 +1000
Message-ID: <ee77f5c20710140412s1eb68991ke552995dbbd226b@mail.gmail.com>
References: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
	 <ee77f5c20710140403j7a88ffa4q579a8c4118d8fd71@mail.gmail.com>
	 <20071014110714.GA17368@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih1Oy-0000Df-N1
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 13:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbXJNLMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 07:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbXJNLMp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 07:12:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:31371 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbXJNLMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 07:12:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1179850rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OIub2NwT/HVh1Q3ir8On56YGw+nJA939auO19o4cDTQ=;
        b=L8LDBXubMi5JQzMdFN3ePmJv+s6a5Rv2FFVclLQR1Qt6NznWevmzGdA61ZU/CY4b7RvDkJ4sO7JFhMbS738oFcjhcmyUX9BK7eybccOAmY+ZhHTBRNOryDTaiOMKz3eilU1mKn6d23pDlIoswErNycSGFBleHxJ4QU8WnVY4lJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLif3pl9vKc6b6HyZ9VSpBn+9NFcL+kcTGeUl2ftUwBdsFRrdZK/q+8m5h3i1wHAZIm4ZL4VBXXq5PtvdNLP8KtHuJZf+iTyH2oQw3UIoQtLmmjJ97W517WIZcqjjugmfWru2HtVHOUKxBivX9GYcnte657OMvtMbgaTFIeNb9Y=
Received: by 10.141.99.4 with SMTP id b4mr2272924rvm.1192360363616;
        Sun, 14 Oct 2007 04:12:43 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sun, 14 Oct 2007 04:12:43 -0700 (PDT)
In-Reply-To: <20071014110714.GA17368@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60830>

On 14/10/2007, Theodore Tso <tytso@mit.edu> wrote:
> On Sun, Oct 14, 2007 at 09:03:48PM +1000, David Symonds wrote:
> > git push <remote> :<branch_name>
> >
> > If the left side of the colon in a push refspec is empty, it deletes
> > the remote ref given by the right hand side.
>
> Cool, thanks!  It's not in the git-push man page.  I'll play with it
> some and then submit a patch update the man page.

Yes, it is, including in the examples section. Under the <refspec>
options description it says:

  Pushing an empty <src> allows you to delete the <dst> ref from
  the remote repository.

In the examples section, it says:

  git push origin :experimental
         Find a ref that matches experimental in the origin repository
         (e.g. refs/heads/experimental), and delete it.


Dave.
