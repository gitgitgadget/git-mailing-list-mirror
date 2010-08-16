From: Vicent Marti <tanoku@gmail.com>
Subject: [GSoC] Libgit2, Summer of Code is over
Date: Mon, 16 Aug 2010 21:46:00 +0200
Message-ID: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5df-0003RJ-DT
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327Ab0HPTqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:46:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38604 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0HPTqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:46:24 -0400
Received: by qwh6 with SMTP id 6so5310600qwh.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=kyAbCZti7nO4b7Sui/bEymuo/5x4/+6dMhfhTP4UjZ0=;
        b=q5N6gFZIZjjTALeIZa8LyQVspS1wvabo6PmEBvHO9DFQ5HMe4VZw0Qqz0S/iDLBDoL
         tqpYqHnaEuYFcKs8iBLEdwP53m/S6ae0Uz8iq+DxfKeiZErkye9CGNq03P625OL2PC8S
         OnjX87dAOPRRNnN/Wk67gL5J9KDjYXbvrmSbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=SpnBWuykY1AKsIgsIK49M7iYMzH40Z5N14D/4tBschjwEe8Hc3+O/jlhvM67fsAcW4
         EV6O0QbfkBEBV7/+sgTWwVVNgAr3a2N/xMYHf2CJKH28k/xH7rHNJcssDwNTczO/QaEv
         94wPhYGus4p6cdxeofH4LfCL/mheWR3FKZp8s=
Received: by 10.224.28.70 with SMTP id l6mr3554183qac.348.1281987980452; Mon,
 16 Aug 2010 12:46:20 -0700 (PDT)
Received: by 10.229.247.138 with HTTP; Mon, 16 Aug 2010 12:46:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153676>

Hello everyone,

the Summer of Code has just reached its end and I'd like to offer some
closure; neither me nor my mentors have been too active on the mailing
list -- to be fair, there was too much work to be done on the library
before it could be considered of general interest. We've been focusing
on that.

The original goals for my project were roughly as follows:

* Add support for revision walking
* Add support for accessing the index file
* Add support for managing references (tags)

After the Summer of Code, here's an overview of what has been accomplished:

* Created an abstraction layer for repository management (object
lookup and automatic memory management)
* Add full support (load, parse, manage, interactively access
contents) for all basic repository objects
    - Commits
    - Trees
    - Tags
    - Blobs
* Add support for revision walking: iterator-based access in random,
topological and time based orders.
* Add support for atomic file locks
* Add support to read, modify and write back Index files
* Add support for the 'TREE' extension on Index files
* Finished implementing the reading of objects from pack files

All these features have been properly documented (regarding its
external API) and are accompanied by their corresponding unit tests.
The final version of the code can be found on my GitHub account, on
the experimental branch [1]. It will be eventually merged back to the
official repository. Overall, it has been an interesting experience,
and it seems like the development of the library is not going to halt
after the Summer of Code.

Thanks for your time and interest during the summer.

Cheers,
Vicent Marti

[1]: http://github.com/tanoku/libgit2-gsoc2010/commits/gsoc-experimental
