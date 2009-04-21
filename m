From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Howto request: going home in the middle of something? v2009
Date: Tue, 21 Apr 2009 08:47:37 -0500
Message-ID: <b4087cc50904210647k7bcc1ecbob20ccf7b56047790@mail.gmail.com>
References: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwGLf-0001Op-Fk
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 15:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbZDUNrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbZDUNrk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 09:47:40 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:17154 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZDUNrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 09:47:40 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1394633qwd.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GFjjDoaseXgnF4jlOhhmuH+oafMJchlMnbmEtXmV09g=;
        b=auE4/DvdcxCv8UCfN+s/0Dfy8XtUmSd6z81f8ZaYkbkcH9bE9jReWDCos1yX4AhL8b
         A69MzkKai1zUb4HQpSxVz/7WyT9klgyUsUuIWiuvl3bMA/Mday21pwR/bdpZbNP1YL7W
         0uVXMu348wZqwNo77bgIwGk9JaBecKnJml1fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FisBqNWobtzjHLgIId7VVaMXq6wERhQQoPuJcuw3KWlJvrglz/5eRvWISN/vi8JoWd
         hz0WiySNAz7DOz51ffB/nSXPomQHfvtnZt6ia/fe96SfcwQ7fsL09gdKBmAs5GsOK/hv
         KcakiJjuk2zKTw1g7IZhDXCrRR9ioau8+dqok=
Received: by 10.224.67.206 with SMTP id s14mr7652782qai.289.1240321657342; 
	Tue, 21 Apr 2009 06:47:37 -0700 (PDT)
In-Reply-To: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117133>

On Tue, Apr 21, 2009 at 08:39, Patrick Doyle <wpdster@gmail.com> wrote:
> But that leaves a bunch of "WIP" commits in my history.

Take a look at git-rebase command, particularly the interactive
option, -i; this allows you to rewrite the history by removing
commits, rearranging commits, and editing/amending commits.

Also, it seems like you're not branching enough.
