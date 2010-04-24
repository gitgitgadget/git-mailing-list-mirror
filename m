From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 04:05:37 -0500
Message-ID: <y2ib4087cc51004240205mc76bcb31n9ec618e24b388e4f@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de> 
	<k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com> 
	<4BD21CAB.8060903@gmx.de> <20100423222522.GA21224@thyrsus.com> 
	<s2mb4087cc51004231638u6f0110fcxd4369ff8d81c7c06@mail.gmail.com> 
	<20100424043821.GA21973@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 24 11:06:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5bJc-0001rZ-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 11:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab0DXJGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 05:06:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:63535 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0DXJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 05:05:59 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1243089fga.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ZTp1qpBy2r9f9HqmQCXGyExjXZfCFfhdxqBZLsLgRak=;
        b=Lr7bj2b3TsmLZTVM6Zsqok3pjjFPdCow0hUdHr70Us3t+4VD9hEptnsv9E70wBFH7q
         MzFGZssFw7QHaAPs9UxHIAy7UwKzNpT8jN6EZPO+RpYDvnqWLu4XLsZ2ruCpUOBisY7R
         3uu2OR1nPmjt5SucjnkDtSZGE284r0AAQ0toE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pDTsW20VivHkNdql4X/mJlUAJ29TXx2fgCwpL/yfD1bdQtzz1jLZNMRFGF+iuqWcZy
         SRYWWkGYe/M09GX7anE0pPVYwU4oT9dH5yDV/vMTkXv62VqAIu/xQaXjrk+hJU7nGS9S
         ElpOf7lG9fevNWV1WAvPBJasJNdvJAPJ8SrF8=
Received: by 10.239.177.77 with SMTP id u13mr108540hbf.96.1272099957792; Sat, 
	24 Apr 2010 02:05:57 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Sat, 24 Apr 2010 02:05:37 -0700 (PDT)
In-Reply-To: <20100424043821.GA21973@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145660>

On Fri, Apr 23, 2010 at 23:38, Eric Raymond <esr@thyrsus.com> wrote:
> And commands that are simple, orthogonal, and easy to mentally model do that.
> You get to provide the policy you want by scripting them.

Just to clarify, I wasn't trying to contradict your conclusions.
