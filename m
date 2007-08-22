From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 15:27:55 +0100
Message-ID: <200708221527.55745.andyparkins@gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 16:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrC9-0005ao-6C
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760943AbXHVO2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760145AbXHVO2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:28:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:8651 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760111AbXHVO2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:28:24 -0400
Received: by fk-out-0910.google.com with SMTP id z23so162510fkz
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 07:28:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DO5PKZpyFhfSpE62WfoHjxKfTcPFtwUDYGnJlYoEcnf2j+eq9y4dt8SliagtiEMHAADl3tAttGBjvb/mq48ZGwko/ADsjmoxOqZoEC5hcQdlOWTIyAwOheHpMWtYW9E4whyFwjuiGTn7+udEaBQYe+94hK0SXwVRsdofjgmiENg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dpn8/LXtgD8rb1t/PJoNS3PL8fXBwozKcgydKLk0KQBrFXrBEl+mLx8nlAgZ7Y553j133I8FxojnBXNEdi1qBFamXK4UZL2VVfZia2uqPkmqa0HsOzVjXRNcauVPlSixLWdIBNvGvzUsk+DMU172kbQr737JN8OSzip4OeqYBBI=
Received: by 10.82.106.14 with SMTP id e14mr1637990buc.1187792902957;
        Wed, 22 Aug 2007 07:28:22 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b30sm1555825ika.2007.08.22.07.27.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Aug 2007 07:28:22 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <86absjenc3.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56382>

On Wednesday 2007 August 22, David Kastrup wrote:

> Could you be so kind as to give a one-sentence summary what the
> benefits over using a shell script would be?  I think this work has
> started before I joined the list, and I'd be interested in the
> motivation for it.  In general, I find shell scripts more pleasant for
> hacking on than C code, and there is no long-term plan to replace all

C is far more portable than shell.  I would imagine the primary target is 
Windows, where the shell code makes life hard for the poor mingw folk.  I 
think in general it's a good thing to reduce the number of dependencies in a 
project.

One could also argue that C is faster, but that's probably irrelevant for the 
remaining shell scripts in git.

As to shell being easier than C: I'd say that's a matter of opinion - you 
might find it harder to hack on C, someone else will find it easier.  It was 
always thus.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
