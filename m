From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 15:24:02 +0300
Message-ID: <37fcd2780903270524x1987a622wb9e693be41fc02c4@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 13:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnB80-0007xB-K8
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 13:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbZC0MYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZC0MYH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 08:24:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:42577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbZC0MYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 08:24:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so21130fgg.17
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ClpQw3Vyz9O0O6+a/GTUPVZhcerfaLZWmsiySvqjXo8=;
        b=Jd7DBNA/eB5kArqgWOjhxFFQAJSvPO9uhujLAfT8Y1/42TDBhzMnRmiJffqqR5Y9aX
         yiLiEj1TWU+GI8GgDKQuAE8zzSh+UtX91ZJzBljmwO4hpHeZ8QZ1Q//iyLc2X0CUoLIg
         g5TucXMcKz9LAuOYTTYcW+NIk7K0WgbXPFq9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vIaJGYbZbS5OTUJ2XVlaA34lfOTAwrVxW+5QWOjNLcVBBy171UR/GESe6VY+sZJUS/
         J992+yq5StSqsMUhemMVb02jvvJAxc65KBjveNcwhMx3sfNNZKBuRjje0SH+acO3zPpM
         oJ4Y1l7cE2an6IkUQdsMIPyKLDjDDjlK3gSEs=
Received: by 10.86.61.13 with SMTP id j13mr367458fga.65.1238156642420; Fri, 27 
	Mar 2009 05:24:02 -0700 (PDT)
In-Reply-To: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114883>

On Fri, Mar 27, 2009 at 10:21 AM, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:
>
> 1) The ability to use the file's time at the time of add/commit instead of the
> current time, and the ability tho check outfiles with the times stored in the
> repository.

To check out with the times stored in repository is a a bad idea, because it
will screw up 'make'.

>
> 2) Keyword substitution. I know it's controverse (dealing with binary files),
> but I'd like to have some automatic version numbering keyword at least:
> Initial idea is that every commit with a change increments the number by one,
> and when merging numbers a and b, the resulting number is max(a, b) + 1.

I am not sure what you want to achieve by having this number. Also, take
a look at "git describe", it may be close to what you want (or may be not).


Dmitry
