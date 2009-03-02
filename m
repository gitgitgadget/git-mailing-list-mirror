From: Caleb Cushing <xenoterracide@gmail.com>
Subject: merge, keeping the remote as a new file?
Date: Sun, 1 Mar 2009 19:16:10 -0500
Message-ID: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 01:19:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdvsO-0001I8-Ci
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 01:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbZCBAQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 19:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZCBAQN
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 19:16:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:60485 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZCBAQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 19:16:12 -0500
Received: by qw-out-2122.google.com with SMTP id 5so3345227qwi.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WSo6LxA1L6NkRBNkzAefaelVYOtFenUMzi3aBV1Tkfg=;
        b=k9JNGmAdEWGyQVFBnMrUnd6c54E/vwJsiI8otMZzBE1iP32bC4WvcXJd2xKnZftol1
         ltUK6yF/eT4rtCfQrEIh22kOVIEnrvMqklTiPOGshb06bYBW+orXroOiamYGtYY80nLe
         nVk+CUfFI2kYiUh+Ky7vE1wRcXiH0obTP0X0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fz2QAe8/VDjwzq00hFljZDPFH8u9P07SxpBy7O5XdQEDbs9upf8mMdKcFUbAfdevmJ
         M94CBAxM2Py4C9f/i5+b9Kpr60dXyXU6xdGa4GfEcQxcPdIctLc1somc2IuVhqIg6LkO
         rO57eqG5N4DHgv8IcL2uqUH65+27JJ3hAlCiI=
Received: by 10.229.94.133 with SMTP id z5mr2597046qcm.38.1235952970043; Sun, 
	01 Mar 2009 16:16:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111897>

 I have an unmerged file... the resolution I'd like to have is
checkout the local one for the current file name. take the remote
version and give it a new file name. what's the best way to do that?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
