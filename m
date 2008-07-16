From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 15:22:41 -0400
Message-ID: <32541b130807161222y68f447c9n5afa6f14d871fe50@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <20080716185930.GP32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCbJ-00062F-NY
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbYGPTWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbYGPTWo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:22:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:11974 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYGPTWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:22:42 -0400
Received: by wx-out-0506.google.com with SMTP id h29so3492160wxd.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y8Y2VCyNxTKESAMeqYm82oH+HSPj+gesHRUykYar9pw=;
        b=wqGyEDCIwXt/xhoWInr2gpLY77yekPXExBvfeAQHW5+YKpH0XSV8j0LlQEqgxU/UyO
         ayXa8OuajqJS5CcJBMzdwlsznOAlLTk3MXKbL9i4kL2LH6IrzhmmCoSdXWjep3vkOai2
         OEP41o79SZIMtWNDdXqxeOrgzKcrjilYvpuWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZvmiFU4fLPDMY/7TYr4pxzAXqYNMav0Y4el1+VL2nfRX6y775sRk/OSnUOcj8r/wBv
         Un+YcJA6W1i23ylXceZMd1tpMhXkqJ/AazQw2VEC81CZfzL0D/GER8TSaoWHE5ssqlZG
         0J9OtLVvk6lN+0m9nQQW2Ur28xuN9yExkQnnQ=
Received: by 10.100.137.11 with SMTP id k11mr2702044and.25.1216236161789;
        Wed, 16 Jul 2008 12:22:41 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 12:22:41 -0700 (PDT)
In-Reply-To: <20080716185930.GP32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88730>

On 7/16/08, Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Jul 16, 2008 at 02:51:30PM -0400, Avery Pennarun wrote:
>  > On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> > >  You can skip merges with "git log --no-merges", just in case you didn't
>  > >  know.
>  > Perhaps this is mostly a user education or documentation issue.  I
>  > know about --no-merges, but it's unclear that this is really a safe
>  > thing to use, particularly if some of your merges have conflicts.
>  > Leaving them out leaves out an important part of history.  Do you use
>  > this option yourself?
>
> Whereas if you rebase, not only you don't show the conflicts resolution,
>  you didn't even _store_ it in the first place. That isn't much of an
>  improvement. :-) (This is the main reason why I prefer to avoid rebase
>  unless absolutely necessary for the workflow.)

The key here is that I'd expect "git log -p" with a rebased merge at
least shows me the actual changes that are in my repository.  "git log
--no-merges" will actually omit things.

Avery
