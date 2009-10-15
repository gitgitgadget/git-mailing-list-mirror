From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Q: how to check for -crlf property for a set of files using git 
	command line?
Date: Thu, 15 Oct 2009 13:15:19 +0400
Message-ID: <85647ef50910150215w1efec91fu16b1fe13f8acec61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:22:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyMXE-0008Jf-O8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 11:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbZJOJP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbZJOJP4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 05:15:56 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:46121 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbZJOJPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 05:15:55 -0400
Received: by ywh6 with SMTP id 6so626653ywh.4
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=nNWOIbf0DscyysmV6SltxfF79RhYlgkPWgrsceWrGf0=;
        b=XSAH0B+nTgUaqBs+9whaDDg+fuYdjS0gN4buB1OH0yeElAKNohVEH0HbEAHoQR0XZq
         y9S6IFH9dgFPBxqbZ92ZM23KUy2+nP8OPwRelB6HrtZcyE95HT4LaaGbepawIi6M/vCB
         /bqByIRo9psCpT20nZRY9CWjy95BJpLjk/33A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bAxiY17rEUX9f4RjptvApMtiZ0/Av01kRuIFebmwi2r3nhhX1s52iSi8x41nURW+9J
         0r19hwlW/TQayHRITrgijVVNLI4fZS50k4wgOC0htkx6J3HR+DErqSC6eJW+wN2ANcRG
         fCbp1w8G8EMWW5Km/fbp6+k/SDi9r78NQOV8A=
Received: by 10.100.244.24 with SMTP id r24mr8505061anh.8.1255598119160; Thu, 
	15 Oct 2009 02:15:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130381>

Hello!

I'm interested how to check for -crlf property (from .gitattributes)
on the set of files using git command line. I'm also interested how to
query for values specified in .gitattributes in general from scripts.
Parsing .gitattributes looks like too complex way of doing this.

Constantine
