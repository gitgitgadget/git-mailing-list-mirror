From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 2/2] History page find toolbar.
Date: Sun, 27 Jan 2008 20:56:45 -0200
Message-ID: <479D0C2D.7060106@intelinet.com.br>
References: <1201401042-5934-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Sun Jan 27 23:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJGPO-0000sp-7h
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 23:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYA0Wyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYA0Wyx
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 17:54:53 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1962 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751820AbYA0Wyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 17:54:52 -0500
Received: (qmail 73798 invoked by uid 0); 27 Jan 2008 20:57:45 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.351145 secs); 27 Jan 2008 22:57:45 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 27 Jan 2008 22:57:44 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <1201401042-5934-1-git-send-email-rogersoares@intelinet.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71836>

Hi Robin,

I've just found a problem, it is affecting the CVS history view. I'll 
investigate it and re-send this patch after your comments.

[]s,
Roger.

--
Roger C. Soares escreveu:
>  	public void createControl(Composite parent) {
> -		localComposite = new SashForm(parent, SWT.VERTICAL);
> +		Font bannerFont = JFaceResources.getBannerFont();
> +		BANNER_FONT_BOLD = new Font(parent.getDisplay(), 
> +				new FontData(bannerFont.getFontData()[0].getName(), bannerFont.getFontData()[0].getHeight(), SWT.BOLD));
> +
> +		parentComposite = parent;
> +		GridLayout parentLayout = new GridLayout();
> +		parentLayout.marginHeight = 0;
> +		parentLayout.marginWidth = 0;
> +		parentLayout.verticalSpacing = 0;
> +		parent.setLayout(parentLayout);
> +		GridData parentData = new GridData(SWT.FILL, SWT.FILL, true, true);
> +		parent.setLayoutData(parentData);
>  
>   
