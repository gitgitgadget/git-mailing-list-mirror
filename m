From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Suggestion: git status --untracked
Date: Mon, 11 Feb 2008 10:46:25 +0100
Message-ID: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVFt-0004GK-EE
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbYBKJq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYBKJq1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:46:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:40774 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYBKJq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:46:26 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4707474wxd.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Orj4MDZWn2zb4+ziyeLZc47H5WtzBhuEUa/k2w6N/SM=;
        b=W9RGTplMkz6lkUZUykSCpq/WOquLV/qwaiXl+VI+zkuPPN/zshhMD8CGuDBa5nQjExfB0BvsBcVnzX2jGvky9BG6purlzO6kOxBIhnOitjKjm/iTsD9Vp+IHeGPBJq+fjeTOfHXkAmggTKlDkFFqWWMp9LgjrGIf0/YXp5ANeAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hzuBmez1jhFiMqp/U8PFPHTqCvouslGcvW+tdHc0xK+ceoD0825VGuELUNCLEO0YEFZAdw1Yn1mOCvb/nw0WZM/zaM/eUDfOHUwAPwp6VQa1KaNLcBo6eQWhykE7lx7Hlhi8f5I33OlqXhCVgYuwrJZeTFTa00gawrh5a3fhVkc=
Received: by 10.143.33.19 with SMTP id l19mr784614wfj.85.1202723185350;
        Mon, 11 Feb 2008 01:46:25 -0800 (PST)
Received: by 10.142.156.10 with HTTP; Mon, 11 Feb 2008 01:46:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73494>

I find myself wanting sometimes to filter out the output of
git-status, to feed it to another command (for example, git-add, or
rm, or cat >> .gitignore). However it's not currently very easy to
parse in a one-liner.

I'm suggesting to add options to control this behaviour. My suggestion
would be (for a start) to add an option --untracked that will list all
untracked files on stdout, without a leading "#\t", and without
listing the added / modified / removed files.

I'm willing to implement it, but I'd like to have some discussion
about the interface first. Is that a good idea at all, and how could
it be improved interface-wise?
