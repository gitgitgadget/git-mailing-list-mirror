From: Pat LeSmithe <qed777@gmail.com>
Subject: Dumb "continuous" commit dumb question
Date: Mon, 18 Aug 2008 20:47:47 -0700
Message-ID: <48AA4263.8090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 05:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVIDa-0006kb-1o
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 05:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbYHSDrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 23:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYHSDrv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 23:47:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:16152 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYHSDrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 23:47:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3492381wfd.4
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 20:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=3UD591UDgJlMZO9xM0WktHm8Y3phGtmA++SoNMRHciQ=;
        b=ef1xn3aEPYIBKFhgd5WuIEJsZQGHHiMkO4I23chkkfXHGSoDZqwdLufrNaSwQdLmSr
         YuRd3qpyeGYaG8AywcSI0TAQyrBgNpNF0P8IJYBEqOA2dPWL/HR1hOol36KlSfjwFqNg
         cnI1yri1PL7CgvzJnI9rn5TIcBCMaK8d4zWKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=CI7SDmfMR1VDM6i2Fk4IgF3rejNbE8abr3/0NKSUYEbYtAmelcGnm9nf9Hnqd9JtBr
         mkUNqVOjS2avY3HnyJ6NyNTiN5YLXiNs8MQWi3njvA8eFk+zeCtA9emYV4TSDJ7exMYY
         eYFW+DTqL6qUf/fYoNp03+rlX/x3smxlij5ms=
Received: by 10.142.240.19 with SMTP id n19mr2340358wfh.191.1219117670169;
        Mon, 18 Aug 2008 20:47:50 -0700 (PDT)
Received: from ?192.168.50.231? ( [76.194.238.32])
        by mx.google.com with ESMTPS id 27sm6081580wff.3.2008.08.18.20.47.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 20:47:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92809>


Hello,

Is it possible to enable git to automatically and continuously "softly"
commit or stage *all* changes to a [subset of] files in a repository,
without my intervention, as they happen?  Perhaps via a daemon which
monitors the disk for explicit file-saving?

Of course, I would still be able to perform explicit commits (with
descriptive comments) and other git commands, in which case there
probably should be smart handling of the recent soft history.  For
example, it could simply be discarded.

I understand that I could simply remember to commit and/or branch early
and often.  But given that changes by an individual on a given branch
are well-ordered by time, and that the "continuous" operation may be
cheap in many situations, a "live" journal could be useful.

Perhaps a better term is branch-aware undo or git with microstructure.

Sorry if this is old stuff or plain crap.

Thanks.

Sincerely,
Pat LeSmith
