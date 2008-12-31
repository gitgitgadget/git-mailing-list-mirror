From: "aaron smith" <beingthexemplarylists@gmail.com>
Subject: git push over http - curl PUT error?
Date: Wed, 31 Dec 2008 02:10:04 -0800
Message-ID: <d7ac1a680812310210r25795e66x35601059103892d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 11:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHy3H-0005lQ-EW
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 11:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYLaKKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 05:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYLaKKH
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 05:10:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:60368 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYLaKKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 05:10:06 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5221103rvb.1
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=OYJgSgyHno6LlM4e4DPWV7YLqzsVHfptO32tizGKGtU=;
        b=vO0O9dTqlHMP3SNYqfX/GJoRrcQxWOVlPb9ISV5VTFyaN3NJOpcZo0DnXjg0os4f9D
         E08RXcqHD0+W14FdcpGFMqLXm5u0HbpYpp98dIZDa0i4lf8iVXg1rfNLDjJcyipoyG0P
         boQFt7RqRfDfKQQ0OTu4gJ97VccO9bZgalEJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RMZLqLcROTQxg9sakc6UiBENLRXiMTj+2gaCSpKSqX1qWij2umg+ZwiglwQ4klRyhT
         LSK2mOwezq1xj5/HG9h5qYdrh8BntmqBx3XESmVMv8F6mpGjcvXbaSfeUFaGoWHYDgQo
         MBhE9MrpFAmX9LLfuDpcWciWI3wdBkHSbZ9tA=
Received: by 10.142.174.8 with SMTP id w8mr6485204wfe.76.1230718204417;
        Wed, 31 Dec 2008 02:10:04 -0800 (PST)
Received: by 10.143.115.3 with HTTP; Wed, 31 Dec 2008 02:10:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104262>

hey all,

I have one last issue to figure out with git over HTTP. This one is
seriously stumping me.

I have a bare git repository here: http://codeendeavor.com/guttershark.git/

And I have a local git repo with some files in it, ready to push to
this public one.

Here's what I do to push to it:

$git push origin master

I then get this output:
""
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from a08e614723ff57047522511a2130d53010ebe0ca
  to   2db4bca0d137f4099973387472cf1666d0290e03
    sending 3 objects
    done
Updating remote server info
PUT error: curl result=22, HTTP code=403
"""

I'm not sure how to get around this.

The git repo permissions are 777, with owner/group apache:apache. I
have DAV on, and the DavLockDB directive. which seems to all be ok.
And I don't have any http authentication on it.. or access control
list for that matter.

Any ideas? Thanks All!
