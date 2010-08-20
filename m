From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git diff shows no output
Date: Fri, 20 Aug 2010 08:38:56 -0500
Message-ID: <20100820133856.GC15736@burratino>
References: <EBCC0FEA-1FF2-4909-BE80-DE280C9D6487@lltech.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Brossollet <chbrosso@lltech.fr>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:43:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRs4-0003sm-Hc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0HTNkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:40:46 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48542 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab0HTNkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:40:45 -0400
Received: by vws3 with SMTP id 3so3077475vws.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Jve4JoVrLWmilPnQuY7MkyQ7fUtB9RHxbSEZkNMxL0U=;
        b=aIgLFGm+8FgeWlgXYrSJILgFcXEcJ7AjL80BOmQKH2usAjISXns3SaUtqx2NLxhFwr
         u1m6o3TOZmzlwHu9cBwU5JRaMxtGvY1/4PAzXF4BLHl7VFu0ha3T90UvjUlpmfATUkuz
         m8fbItcNAq/HxBRnepl1TvxqQVpeMpMu6aYnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SSHrKmY7CahBEnv2Q7kwLD7zKhj2jRqix8h2R36X1j96fNXm4pI0QFusnoOuVtYSOl
         EJl2V6Em6GQOv8sRHPo4wWSzR9jzM5w5lXE/mELtki20EuBXXeQt4yyKbbzJi5RfFcTn
         LGksh+tk0FsmrtCM13NPigjNklJ6oJWlelbiM=
Received: by 10.220.88.22 with SMTP id y22mr922033vcl.12.1282311644241;
        Fri, 20 Aug 2010 06:40:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m9sm1040342vcz.17.2010.08.20.06.40.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 06:40:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <EBCC0FEA-1FF2-4909-BE80-DE280C9D6487@lltech.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154036>

Hi!

Charles Brossollet wrote:

> "git diff" shows nothing, while "git diff | cat" shows the diff, as
> well as "git diff>output.txt" puts diff in output.txt.

"git diff" paginates its output by default.  Perhaps your $LESS
contains -F but not -X?

Hope that helps,
Jonathan
