From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 14:51:38 -0400
Message-ID: <32541b130806271151sdf6ce8hfeaa6d61515e8b5e@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <20080626112233.GA17625@cuci.nl>
	 <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
	 <m3lk0qiy2i.fsf@localhost.localdomain>
	 <32541b130806271056k4698a607r11e9fbaf9102e6f1@mail.gmail.com>
	 <56b7f5510806271109p58b4ce47ucdcd382faa463015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCJ3w-0001n2-BN
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbYF0Svl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYF0Svk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:51:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:13818 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbYF0Svj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:51:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so558205fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E3K9kt3hJnEnmSCQC1D8zV50+L2NvTGvQrwVns3Zpvs=;
        b=xJa6tTqG/P//yYd1t7jkAix057INlM0GLJMcQbqeGJJcw9aulan3NyUH6S9lzz/StR
         iVGpZOCS5nMNuWWbSQlScCcMpFL2A7g1ThMavr2JsxXyFDP6cPK7G0D2e3s/yArgy9D2
         bT/ueknu0GN31vIg8kDNxy6ngPemXgfs/hofY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=azl4xHJ8SAFOxjhcrVqKTN9ifNm3++3lbDs4+RX8m+Y2ifgtc2Dz2OsSv0UnL7wJAM
         ZNODdIKy++UhfcAX5F1tdt5b4wDR009oGqkcAR4gpYp0DpyQbrfV7+sdOAG/2hGTeow1
         BhLSGbNrYhk7S6V9Rf5a/qh37xLFjF1ws8bqs=
Received: by 10.82.118.1 with SMTP id q1mr73260buc.52.1214592698216;
        Fri, 27 Jun 2008 11:51:38 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Fri, 27 Jun 2008 11:51:38 -0700 (PDT)
In-Reply-To: <56b7f5510806271109p58b4ce47ucdcd382faa463015@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86624>

On 6/27/08, Dana How <danahow@gmail.com> wrote:
> It sounds sane to me b/c I had the same reaction to this discussion.
>  You mean "all the files in the _worktree_" ?
>  You would use e.g. inotify on all the directories except .git?
>  This would be very helpful with an extremely large number of files.

Yes, that's the idea.  In Win32, it would use something other than
inotify, but otherwise it should work about the same.

Avery
