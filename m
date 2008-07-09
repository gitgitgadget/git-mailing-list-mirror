From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Idea: "live branches"?
Date: Wed, 9 Jul 2008 12:48:25 -0400
Message-ID: <32541b130807090948q65d64ea9s7a3c0639c2f2daa2@mail.gmail.com>
References: <m28wwbz8h7.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Rychter" <jan@rychter.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGcr9-0007UJ-Oy
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 18:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYGIQs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 12:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYGIQs2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 12:48:28 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:51118 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYGIQs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 12:48:27 -0400
Received: by el-out-1112.google.com with SMTP id z25so478432ele.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/83CfLxM25O6lSPFLTc12eoqUx/jnPsHDBqmPF0IU3E=;
        b=VJ6qdL9Ay9U3OmyWBEI1OG9MbYQerRJHCOKIl6jKc/6WHTj9SRm0BZICCMkXorTtki
         lkrhZzbtOMLg33qSdj2xSTbVZ9v8/726ldvZ9tcgW+qjnMjcaHD5r1HDoBVHmQfE6nAQ
         7wdCu4633NS8gkauksJIP9D2czYy1LfA1ctv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b1sP6Q7ADaQs5T6RZlZ7A08v8DGCgD7TAcIJprHdb/MaTzPM5xdSFikC3Vrv01i6HR
         kP+yBNsxVetWMJ4aWNLaFi67FhxE9rnqMlo2sfGWyIiKZvNkxt1N0jdPt0kKYobmSNjF
         iaGyqjBs9M1mtz8q9WK/mROfMjC4u+L/t2HJ0=
Received: by 10.151.113.11 with SMTP id q11mr12767492ybm.30.1215622105458;
        Wed, 09 Jul 2008 09:48:25 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 9 Jul 2008 09:48:25 -0700 (PDT)
In-Reply-To: <m28wwbz8h7.fsf@tnuctip.rychter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87893>

On 7/9/08, Jan Rychter <jan@rychter.com> wrote:
>  The way this would work is I would have one or two long-term development
>  branches, and each of those would depend on a list of "live branches",
>  managed by a tool similar to StGIT. I should be able to commit to either
>  the main development branch, or to one of the "live branches", in which
>  case I should be able to easily "resync" the main development branch (do
>  a merge or a rebase, but I would prefer the tool to first remove old
>  merge commits, so as not to clutter history).

Hmm, git rebase already removes old merge commits.  In my own
workflow, I tend to do repeated merges of the "live branch" into my
feature branches during development, then do a rebase occasionally to
clean up the patch set, especially right before merging it into
master.  This seems pretty painless to me.  What specific problem are
you having that prevents this from working?

Have fun,

Avery
